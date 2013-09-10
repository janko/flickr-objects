require "vcr"
require_relative "settings"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :faraday
  config.default_cassette_options = {
    record: :new_episodes,
  }
  config.allow_http_connections_when_no_cassette = true

  SETTINGS.each do |name, value|
    config.filter_sensitive_data("<#{name.upcase}>") { value }
  end

  config.configure_rspec_metadata!
end
