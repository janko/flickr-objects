require "flickr/objects"

class Flickr
  map_interface :media,  Media
  map_interface :photos, Photo
  map_interface :videos, Video
end

Dir["#{Flickr::ROOT}/flickr/api/api_methods/*.rb"].each { |f| require f }
Flickr.register_api_methods!
Flickr::Object.children.each(&:register_api_methods!)

Dir["#{Flickr::ROOT}/flickr/api/*.rb"].each { |f| require f }
