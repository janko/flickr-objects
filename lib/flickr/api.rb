require "flickr/objects"
require "flickr/api_caller"

class Flickr
  map_interface :media,  Media
  map_interface :photos, Photo
  map_interface :videos, Video
end

Dir["#{Flickr::ROOT}/flickr/api/api_methods/*.rb"].each { |f| require f }
Dir["#{Flickr::ROOT}/flickr/api/*.rb"].each { |f| require f }
