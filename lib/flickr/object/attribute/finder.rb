class Flickr
  class Object
    class Attribute::Finder
      def initialize(instance)
        @instance = instance
      end

      def find(attribute, *args)
        attribute_values = @instance.class.attribute_values[attribute] || []
        attribute_values << ->{ @hash.fetch(attribute.to_s) }

        try_each(attribute_values) do |attribute_value|
          result = @instance.instance_exec(*args, &attribute_value)
          return result unless result.nil?
        end

        nil
      end

      private

      def try_each(enum, &block)
        enum.each do |element|
          begin
            yield element
          rescue
          end
        end
      end
    end
  end
end
