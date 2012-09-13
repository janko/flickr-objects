class Flickr
  class Photo < Media
  end
end

Flickr::Photo.register_api_methods!
