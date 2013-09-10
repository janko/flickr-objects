require "flickr/object/list/#{Flickr.pagination || "normal"}"
require "flickr/attributes"

module Flickr
  class Object

    ##
    # Flickr offers pagination when returning collection responses, so this
    # class encapsulates this data, and also provides useful finder methods,
    # similar to ActiveRecord's.
    #
    class List

      extend Flickr::Attributes

      attribute :current_page,  Integer
      attribute :per_page,      Integer
      attribute :total_pages,   Integer
      attribute :total_entries, Integer

      ##
      # @see Flickr::Object#attributes
      #
      attr_reader :attributes

      ##
      # If block is given, does a regular Enumerable#find, otherwise finds by
      # ID(s).
      #
      # @param id_or_ids [String, Array<String>] ID(s) of the object(s) to find.
      # @return [Flickr::Object, Array<Flickr::Object>, nil]
      #
      def find(id_or_ids = nil)
        return super if block_given?

        if id_or_ids.is_a?(Enumerable)
          id_or_ids.map { |id| find(id) }
        else
          find_by(id: id_or_ids.to_s)
        end
      end

      ##
      # Finds by a hash of attributes. Supports nesting (see the example).
      #
      # @param attributes [Hash] Attributes by which to search.
      # @return [Flickr::Object, nil]
      # @example
      #   photos.find_by(id: "1", owner: {username: "janko"})
      #
      def find_by(attributes)
        find { |object| object.matches?(attributes) }
      end

      ##
      # Filters by a hash of attributes. Supports nesting (see the example).
      #
      # @param attributes [Hash] Attributes by which to search
      # @return [Array<Flickr::Object>]
      # @example
      #   photos.filter(owner: {username: "janko"})
      #
      def filter(attributes)
        select { |object| object.matches?(attributes) }
      end

      ##
      # @deprecated It provides #find_by_<attribute> methods, but they are now
      #   deprecated in favor of the obviously superior {#find_by} (repeating
      #   ActiveRecord's mistake :P).
      #
      def method_missing(name, *args, &block)
        if name.to_s =~ /find_by_\w+/
          Flickr.deprecation_warn "#find_by_<attribute>(<value>) is deprecated; use #find_by(:<attribute> => <value>) instead"
          attribute_name = name[/(?<=find_by_)\w+/]
          find { |object| object.send(attribute_name) == args.first }
        else
          super
        end
      end

    end

  end
end

require_relative "attribute_locations/list"
