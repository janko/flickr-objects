class Flickr
  class Permissions < Object

    attribute :can_comment?,  Boolean
    attribute :can_add_meta?, Boolean
    attribute :can_download?, Boolean
    attribute :can_blog?,     Boolean
    attribute :can_print?,    Boolean
    attribute :can_share?,    Boolean

  end
end
