begin
  require "debugger"
rescue LoadError
end

Flickr.configure do |config|
  config.api_key = ENV['FLICKR_API_KEY']
  config.shared_secret = ENV['FLICKR_SHARED_SECRET']
  config.access_token_key = ENV['FLICKR_ACCESS_TOKEN']
  config.access_token_secret = ENV['FLICKR_ACCESS_SECRET']
end

PHOTO_ID = "7932536558"
