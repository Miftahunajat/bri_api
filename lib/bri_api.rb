require 'faraday'
require 'json'
require 'time'

class BriApi
  attr_accessor :signature, :timestamp, :fullpath, :token, :timestamp

  # @params :id_key [string]
  # @params :secret_key [string]
  def initialize(params)
    @url = 'https://sandbox.partner.api.bri.co.id'
    @get_url = 'https://partner.api.bri.co.id'

    @ID_KEY = params[:id_key]
    @SECRET_KEY = params[:secret_key]
  end

  # @params :url [string]
  # @params :account_number [string]
  def get_account_info(params)
    params[:url] ||= @url
    path = '/sandbox/v2/inquiry/' + params[:account_number]
    response = get_request(path, params)
    JSON.parse(response.body)['Data']
  end

  private

  def get_request(path, params)
    @signature = get_signature(path, 'GET', '')
    @fullpath = params[:url] + path
    response = connection.get(@fullpath) do |r|
      r.headers['Authorization'] = 'Bearer ' + @token
      r.headers['BRI-Signature'] = @signature
      r.headers['BRI-TIMESTAMP'] = @timestamp
    end
    response
  end

  def post_request(url, params)
    @signature = get_signature(url, 'POST', params.to_json)
    @fullpath = @get_url + url
    respon = connection.post(@get_url + url) do |r|
      r.headers['Authorization'] = 'Bearer ' + @token
      r.headers['BRI-Signature'] = @signature
      r.headers['BRI-TIMESTAMP'] = @timestamp
      r.headers['Content-Type'] = 'application/json'
      r.body = params.to_json
    end
    respon
  end

  def get_access_token
    url = '/oauth/client_credential/accesstoken?grant_type=client_credentials'
    res = Faraday.post(@url + url, {client_id: @ID_KEY, client_secret: @SECRET_KEY})
    JSON.parse(res.body)['access_token']
  end

  def get_signature(path, verb, body)
    @token = get_access_token
    @timestamp = Time.now.utc.iso8601(3)
    payload = "path=" + path + "&verb=" + verb + "&token=Bearer " + @token +
                    "&timestamp=" + @timestamp + "&body=" + body
    puts payload
    create_signature(payload)
  end

  def create_signature(payload)
    digest = OpenSSL::Digest.new('sha256')
    key = @SECRET_KEY
    hexdigest = OpenSSL::HMAC.hexdigest(digest, key, payload)
    hex_to_base64_digest(hexdigest)
  end

  def hex_to_base64_digest(hexdigest)
    [[hexdigest].pack("H*")].pack("m0")
  end

  def connection
    connection = Faraday.new(:url => @url) do |c|
      c.use Faraday::Request::UrlEncoded
      c.use Faraday::Response::Logger
      c.adapter Faraday::Adapter::NetHttp
      connection
    end
  end
end