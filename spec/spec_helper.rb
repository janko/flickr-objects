require "flickr-objects"
require "yaml"
require "erb"
require "vcr"

RSPEC_DIR = File.expand_path(File.dirname(__FILE__))
Dir["#{RSPEC_DIR}/support/**/*.rb"].each { |f| require f }

CREDENTIALS_FILE = "#{RSPEC_DIR}/flickr.yml"

if File.exists?(CREDENTIALS_FILE)
  CREDENTIALS = YAML.load(ERB.new(File.read(CREDENTIALS_FILE)).result).symbolize_keys
else
  puts <<-EOS
### ERROR ###
Credential file not found at spec/flickr.yml.
Copy spec/flickr.yml.example and fill in your credentials.
  EOS
  exit
end

require_relative "setup"

RSpec.configure do |config|
  config.before(:each) do
    Flickr.configure do |config|
      config.api_key             = CREDENTIALS[:api_key]
      config.shared_secret       = CREDENTIALS[:shared_secret]
      config.access_token_key    = CREDENTIALS[:access_token]
      config.access_token_secret = CREDENTIALS[:access_token_secret]
    end
  end
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
  CREDENTIALS.each do |name, value|
    config.filter_sensitive_data("<#{name.upcase}>") { value }
  end
end
