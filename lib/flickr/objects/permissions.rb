require "flickr/objects/attribute_values/permissions"

class Flickr
  class Permissions < Object

    attribute :can_comment?,  type: Boolean
    attribute :can_add_meta?, type: Boolean
    attribute :can_download?, type: Boolean
    attribute :can_blog?,     type: Boolean
    attribute :can_print?,    type: Boolean
    attribute :can_share?,    type: Boolean

  end
end
