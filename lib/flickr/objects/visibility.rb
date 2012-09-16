require "flickr/objects/attribute_values/visibility"

class Flickr
  class Visibility < Object

    attribute :public?,   Boolean
    attribute :friends?,  Boolean
    attribute :family?,   Boolean
    attribute :contacts?, Boolean

  end
end
