require "flickr/object"

# Define all classes now, so that files below can be normally required
class Flickr
  class Person < Object; end
end

Dir["#{Flickr::ROOT}/flickr/objects/*.rb"].each { |f| require f }
Dir["#{Flickr::ROOT}/flickr/objects/attribute_values/*.rb"].each { |f| require f }
