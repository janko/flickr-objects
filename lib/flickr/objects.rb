require "flickr/object"

# Define all classes now, so that files below can be normally required
class Flickr
  class Person      < Object; end
  class Media       < Object; end
  class Photo       < Media;  end
  class Video       < Media;  end
  class Visibility  < Object; end
  class Permissions < Object; end
  class Note        < Object; end
  class Tag         < Object; end
end

Dir["#{Flickr::ROOT}/flickr/objects/*.rb"].each { |f| require f }
Dir["#{Flickr::ROOT}/flickr/objects/attribute_values/*.rb"].each { |f| require f }
