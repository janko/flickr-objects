class Flickr
  class Tag < Object

    attribute :id,           String
    attribute :author,       Person
    attribute :raw,          String
    attribute :content,      String
    attribute :machine_tag?, Boolean

  end
end
