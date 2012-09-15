require "flickr/objects/attribute_values/visibility"

class Flickr
  class Visibility < Object

    attribute :public?,   type: Boolean
    attribute :friends?,  type: Boolean
    attribute :family?,   type: Boolean
    attribute :contacts?, type: Boolean

  end
end
