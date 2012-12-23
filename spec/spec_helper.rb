require_relative "setup_load_paths"

require "flickr-objects"
require "vcr"

require_relative "setup"
Dir[File.join(ROOT, "spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.filter_run_excluding pro: true

  config.before(:each) do
    Flickr.configure do |config|
      CREDENTIALS.each do |name, value|
        config.send("#{name}=", value)
      end
    end
  end

  config.include RSpecHelpers
  config.extend VCR::RSpec::Macros

  config.treat_symbols_as_metadata_keys_with_true_values = true
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :faraday
  config.default_cassette_options = {
    record: :new_episodes,
    serialize_with: :syck, # So that Ruby doesn't dump response bodies in binary format
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_param(:api_key) # Don't require the API key.
    ]
  }

  CREDENTIALS.each do |name, value|
    config.filter_sensitive_data("<#{name.upcase}>") { value }
  end

  config.configure_rspec_metadata!
end
