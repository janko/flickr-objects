case Flickr.configuration.pagination
when nil            then require_relative "list/array"
when :will_paginate then require_relative "list/will_paginate"
when :kaminari      then require_relative "list/kaminari"
else                     raise Flickr::Error, "supported paginations are :will_paginate or :kaminari (you put #{Flickr.configuration.pagination.inspect})"
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
