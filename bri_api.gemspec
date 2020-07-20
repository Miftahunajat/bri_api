$LOAD_PATH << File.expand_path("lib", __dir__)

Gem::Specification.new do |s|
  s.name = "bri_api"
  s.version = "0.7.0".freeze
  s.summary = "bri_api provides a framework and DSL for integrating with Bank Rakyat Indonesia API."
  s.description = "bri_api provides a framework and DSL for integrating with Bank Rakyat Indonesia API." \
    " The current version only works with sandbox version of Bank Rakyat Indonesia"

  s.files =
    Dir.glob("lib/**/*") +
    %w[CONTRIBUTING.md GETTING_STARTED.md LICENSE NAME.md NEWS.md README.md .yardopts]

  s.require_path = "lib"
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  s.authors = ["Miftahun Najat"]
  s.email = ["miftahunajat@gmail.com"]

  s.homepage = "https://github.com/miftahunajat/bri-api"

  s.add_dependency("faraday", "~> 1.0.1")

  s.license = "MIT"
end