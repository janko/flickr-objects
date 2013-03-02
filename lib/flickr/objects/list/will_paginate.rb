require "will_paginate/collection"

class Flickr
  class List < WillPaginate::Collection
    extend Flickr::Object::Attribute

    def initialize(objects, hash)
      @hash = hash
      super(
        retrieve_value(:current_page, Integer),
        retrieve_value(:per_page, Integer),
        retrieve_value(:total_entries, Integer)
      )
      replace(objects)
    end
  end
end
