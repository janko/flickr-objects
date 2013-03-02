class Flickr
  class List < Array
    extend Flickr::Object::Attribute

    attribute :current_page,  Integer
    attribute :per_page,      Integer
    attribute :total_pages,   Integer
    attribute :total_entries, Integer

    def initialize(objects, hash)
      @hash = hash
      super(objects)
    end
  end
end
