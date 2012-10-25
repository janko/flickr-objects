require "date"
require "flickr/helpers/boolean"

class Flickr
  class Object
    class Attribute::Converter
      def initialize(instance)
        @instance = instance
      end

      def convert(value, type)
        return value if value.nil?

        if type.is_a?(Array)
          return value.map {|item| convert(item, type.first) }
        elsif Object.children.include?(type)
          return type.new(value, @instance.client)
        else
          try_each(CONVERTERS[type]) do |converter|
            return converter.call(value)
          end
        end

        value
      end

      CONVERTERS = {
        ::Object  => [->(value){ value }],
        String    => [->(value){ String(value) }],
        Time      => [->(value){ Time.at(Integer(value)) }, ->(value){ DateTime.parse(value).to_time }],
        Boolean   => [->(value){ Integer(value) == 1 }],
        Integer   => [->(value){ Integer(value) }],
        Float     => [->(value){ Float(value) }],
      }

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
