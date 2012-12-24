require "yaml"
require "erb"
require "active_support/core_ext/hash/except"
require "active_support/core_ext/hash/keys"
begin
  require "pry"
rescue LoadError
end
require "flickr-objects"

ROOT = File.expand_path("..", File.dirname(__FILE__))

begin
  CREDENTIALS = YAML.load(ERB.new(File.read(File.join(ROOT, "/spec/flickr.yml"))).result).symbolize_keys
rescue Errno::ENOENT
  puts <<-EOS
### ERROR ###
Credential file not found at spec/flickr.yml.
Copy spec/flickr.yml.example and fill in your credentials.
  EOS
  exit
end

Flickr.configure do |config|
  CREDENTIALS.each do |name, value|
    config.send("#{name}=", value)
  end
end

PHOTO_ID        = "7986395865"
OTHER_PHOTO_ID  = "8130464513"
EXTRAS          = "description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_q,url_t,url_s,url_n,url_m,url_z,url_c,url_l,url_h,url_k,url_o"

SET_ID          = "72157631860874542"

PERSON_ID       = "78733179@N04"
PERSON_EMAIL    = "flickriegem@yahoo.com"
PERSON_USERNAME = "@janko-m"
