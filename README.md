# bri-api
bri_api provides a framework and DSL for integrating with Bank Rakyat Indonesia API. The current version only works with sandbox version of Bank Rakyat Indonesia.
For more about the BRI official Documentation go to [here](https://apidocs.bri.co.id/)

## Documentation

## Installation
Add the following line to Gemfile:
```
gem 'bri_api'
```

and run bundle install from your shell.

To install the gem manually from your shell, run:
```
gem install bri_api
```

## How to use
Below is list command of transaction for BRI Api.
Replace the YOUR_CONSUMER_KEY and YOUR_CONSUMER_SECRET with your own key and secret from BRI sites.
### get account information
Parameters: <br>
* ***account_number :*** Your client bank account number
* ***url :*** since the base url for Sandbox BRI is under maintenance you should replace with the url: params instead.

```ruby
client = BriApi.new(id_key: YOUR_CONSUMER_KEY, secret_key: YOUR_CONSUMER_SECRET)
response = client.get_account_info(account_number: '888801000157508', url: 'https://partner.api.bri.co.id')
print response
```

Sample Response : 
```ruby
{
  "sourceAccount"=>"888801000157508", 
  "sourceAccountName"=>"ALOYSIUS AGUS WARI Z", 
  "sourceAccountStatus"=>"Rekening Aktif", 
  "sourceAccountBalace"=>"1146275.87", 
  "registrationStatus"=>"Rekening terdaftar an. BRI Application Program Interface"
}
```
### create Briva endpoint
Parameters: <br>
* ***institution_code :*** Your client institution code
* ***briva_no :*** your client briva no
* ***cust_code :*** your client customer number
* ***name :*** Name of your client customer that you want display
* ***amount :*** The amount in Virtual Account
* ***keterangan :*** [default = ""] Description of the Virtual Account
* ***expired_days :*** [default = 1] Number of days when the Virtual Account would be expired.
```
client = BriApi.new(id_key: YOUR_CONSUMER_KEY, secret_key: YOUR_CONSUME_SECRET)
response = client.create_briva_endpoint(
  institution_code: "J104408", briva_no: "77777", cust_code: '3456789200',
  name: "Miftahun Najat", amount: "15000", keterangan: "Invoice", expired_days: 1
)
print response
```

Sample Response : 
```ruby
{
"status"=>true, 
"responseDescription"=>"Success", 
"responseCode"=>"00", 
"data"=>{
  "institutionCode"=>"J104408", 
   "brivaNo"=>"77777", 
   "custCode"=>"3456789201", 
   "nama"=>"Miftahun Najat", 
   "amount"=>"15000", 
   "keterangan"=>"", 
   "expiredDate"=>"2020-07-21 00:00:00"
 }
}
```
### check Briva status
Parameters: <br>
* ***institution_code :*** Your client institution code
* ***briva_no :*** your client briva no
* ***cust_code :*** your client customer number
```
client = BriApi.new(id_key: YOUR_CONSUMER_KEY, secret_key: YOUR_CONSUME_SECRET)
response = client.get_briva_status(institution_code: "J104408", briva_no: "77777", cust_code: '3456789200')
print response
```

Sample Response : 
```ruby
{
"status"=>true, 
"responseDescription"=>"Success", 
"responseCode"=>"00",
"data"=>{
  "institutionCode"=>"J104408", 
  "BrivaNo"=>"77777", 
  "CustCode"=>"3456789200", 
  "Nama"=>"MIFTAHUN NAJAT", 
  "Amount"=>"10000.00", 
  "Keterangan"=>"", 
  "statusBayar"=>"N", 
  "expiredDate"=>"2020-03-10 09:57:26", 
  "lastUpdate"=>nil
 }
} 
```
  
## Supported Ruby versions
The current supported ruby version is `>= 2.5.0`
