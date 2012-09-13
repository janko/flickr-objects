class Flickr
  class Video < Media
  end
end

Flickr::Video.register_api_methods!
