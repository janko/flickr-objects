# This is the file that `$ rake console` requires
require "yaml"
require "erb"
begin
  require "debugger"
rescue LoadError
end
require_relative "support/core_ext"

RSPEC_DIR = File.expand_path(File.dirname(__FILE__))
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

Flickr.configure do |config|
  config.api_key             = CREDENTIALS[:api_key]
  config.shared_secret       = CREDENTIALS[:shared_secret]
  config.access_token_key    = CREDENTIALS[:access_token]
  config.access_token_secret = CREDENTIALS[:access_token_secret]
end

PHOTO_ID      = "7986395865"
VIDEO_ID      = "7989540600"
MEDIA_ID      = PHOTO_ID
EXTRAS        = "description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_q,url_t,url_s,url_n,url_m,url_z,url_c,url_l,url_h,url_k,url_o"

SET_ID        = "72157631860874542"

USER_ID       = "78733179@N04"
USER_EMAIL    = "flickriegem@yahoo.com"
USER_USERNAME = "@janko-m"
