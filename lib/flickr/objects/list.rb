class Flickr
  case Flickr.configuration.pagination
  when nil

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

  when :will_paginate

    require "will_paginate/collection"

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

  when :kaminari

    require "kaminari"
    require "kaminari/models/array_extension"

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

  else
    raise Error, "supported paginations are :will_paginate or :kaminari (you put \":#{Flickr.configuration.pagination}\")"
  end
end

require_relative "attribute_values/list"

class Flickr
  class List
    def find(id = nil)
      if block_given?
        super
      else
        if id.is_a?(Array)
          ids = id.map(&:to_s)
          select { |object| ids.include?(object.id) }
        else
          super() { |object| object.id == id.to_s }
        end
      end
    end

    def method_missing(name, *args, &block)
      if name.to_s =~ /find_by_\w+/
        attribute_name = name[/(?<=find_by_)\w+/]
        find { |object| object.send(attribute_name) == args.first }
      else
        super
      end
    end
  end
end
