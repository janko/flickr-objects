require "flickr-objects"
require "vcr"
begin
  require "debugger"
rescue LoadError
end

RSPEC_DIR = File.expand_path(File.dirname(__FILE__))
Dir["#{RSPEC_DIR}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.before(:each) { load("#{RSPEC_DIR}/credentials.rb") }
  config.include RSpecHelpers
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.default_cassette_options = {
    record: :new_episodes,
    serialize_with: :syck, # So that Ruby doesn't dump response bodies in binary format
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_param(:api_key) # Don't require the API key.
    ]
  }
  config.filter_sensitive_data('API_KEY')      { ENV['FLICKR_API_KEY'] }
  config.filter_sensitive_data('ACCESS_TOKEN') { ENV['FLICKR_ACCESS_TOKEN'] }
  config.configure_rspec_metadata!
end
