require "flickr/object"

class Flickr
  # Official objects
  class Person < Object; end
  class Media  < Object; end
  class Photo  < Media;  end
  class Video  < Media;  end
  class Set    < Object; end

  # Meta objects
  class Visibility   < Object; end
  class Permissions  < Object; end
  class Note         < Object; end
  class Tag          < Object; end
  class Location     < Object; end
  class UploadTicket < Object; end

  class Collection  < Object; end
end

Flickr::Object.children.each do |klass|
  underscored_name = klass.name.split("::").last.sub(/(?<=\w)(?=[A-Z])/, "_").downcase
  begin
    require "flickr/objects/#{underscored_name}"
  rescue LoadError
  end
end
