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
USER_ID = "78733179@N04"
EXTRAS = "description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_q,url_t,url_s,url_n,url_m,url_z,url_c,url_l,url_h,url_k,url_o"
