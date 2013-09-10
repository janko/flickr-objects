require "kaminari"
require "kaminari/models/array_extension"

module Flickr
  class Object

    class List < Kaminari::PaginatableArray

      ##
      # @private
      #
      def initialize(attributes)
        raise ArgumentError, "attributes should not be nil" if attributes.nil?

        @attributes = attributes
        super([], offset: current_page, limit: per_page, total_count: total_entries)
      end

      ##
      # @private
      #
      def populate(objects)
        replace(objects)
        self
      end

    end

  end
end
