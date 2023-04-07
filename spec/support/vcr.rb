require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join("spec","fixtures","vcr_cassettes")
  config.hook_into :webmock
  config.configure_rspec_metadata!
  #config.ignore_localhost = true
  config.filter_sensitive_data("<CREDENTIAL>") { Rails.application.credentials.dig(:weather_api,:key) }
end