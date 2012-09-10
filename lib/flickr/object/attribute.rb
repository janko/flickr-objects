require "date"
require "flickr/boolean"

class Flickr
  class Object
    module Attribute
      def self.extended(base)
        base.send(:include, InstanceMethods)
      end

      def attribute(name, type = nil)
        define_method(name) do
          value = get_attribute_value(name)
          convert(value, type)
        end
      end

      def attribute_values; @attribute_values ||= {} end
      def attribute_values=(hash)
        @attribute_values = hash
        children.each do |child|
          child.attribute_values = hash.merge(child.attribute_values || {})
        end
      end

      module InstanceMethods
        def get_attribute_value(name)
          attribute_values = self.class.attribute_values[name] || []
          attribute_values << ->(h) { h[name.to_s] }
          try_each(attribute_values) do |attribute_value|
            value = attribute_value.call(@hash)
            return value unless value.nil?
          end

          nil
        end

        def convert(value, type)
          return value if (type.nil? or value.nil?)

          if type.is_a?(Array)
            return value.map { |item| convert(item, type.first) }
          elsif type.respond_to?(:attribute)
            return type.new(value, client)
          else
            try_each(CONVERTERS[type]) do |converter|
              return converter.call(value)
            end
          end

          value
        end

        CONVERTERS = {
          String  => [->(v) { String(v) }],
          Time    => [->(v) { Time.at(Integer(v)) }, ->(v) { DateTime.parse(v).to_time }],
          Boolean => [->(v) { Integer(v) == 1 }],
          Integer => [->(v) { Integer(v) }]
        }

        module_function

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
end
