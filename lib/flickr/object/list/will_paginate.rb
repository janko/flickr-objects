require "will_paginate/collection"

module Flickr
  class Object

    class List < WillPaginate::Collection

      ##
      # @private
      #
      def initialize(attributes)
        raise ArgumentError, "attributes should not be nil" if attributes.nil?

        @attributes = attributes
        @attributes = {"page" => 1, "per_page" => 1, "total" => 1} if @attributes.empty?

        super(current_page, per_page, total_entries)
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
