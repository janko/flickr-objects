require "flickr/object"

class Flickr
  # Official objects
  class Person < Object; end
  class Photo  < Object; end
  class Set    < Object; end

  # Meta objects
  class Visibility   < Object; end
  class Permissions  < Object; end
  class Note         < Object; end
  class Tag          < Object; end
  class Location     < Object; end
  class UploadTicket < Object; end

  class List < Object; end
end

objects = Flickr::Object.children.dup
objects.each do |object|
  underscored_name = object.name.split("::").last.split(/(?<=\w)(?=[A-Z])/).map(&:downcase).join("_")
  require "flickr/objects/#{underscored_name}"
end
