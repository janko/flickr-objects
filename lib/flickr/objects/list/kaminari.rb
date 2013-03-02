require "kaminari"
require "kaminari/models/array_extension"

class Flickr
  class List < Kaminari::PaginatableArray
    extend Flickr::Object::Attribute

    def initialize(objects, hash)
      @hash = hash
      super(objects,
        offset:      retrieve_value(:current_page, Integer),
        limit:       retrieve_value(:per_page, Integer),
        total_count: retrieve_value(:total_entries, Integer)
      )
    end
  end
end
