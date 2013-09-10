module Flickr
  class Object

    class List < Array

      ##
      # @private
      #
      def initialize(attributes)
        raise ArgumentError, "attributes should not be nil" if attributes.nil?

        @attributes = attributes
        super()
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
