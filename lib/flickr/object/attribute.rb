require "date"
require "flickr/boolean"

class Flickr
  class Object
    module Attribute
      def self.extended(base)
        base.send(:include, InstanceMethods)
      end

      def attribute(name, options = {})
        define_method(name) do
          value = convert(get_attribute_value(name), options[:type])
          value != nil ? value : options[:default]
        end

        aliases = options[:alias] || []
        aliases.each do |alias_|
          define_method(alias_) do
            send(name)
          end
        end
      end

      attr_reader :attribute_values
      def attribute_values=(hash)
        @attribute_values = hash
        if respond_to?(:children)
          children.each {|child| child.attribute_values = self.attribute_values }
        end
      end

      module InstanceMethods
        def get_attribute_value(name)
          attribute_values = self.class.attribute_values[name] || []
          attribute_values << proc { @hash.fetch(name.to_s) }
          try_each(attribute_values) do |attribute_value|
            result = instance_eval(&attribute_value)
            return result unless result.nil?
          end

          nil
        end

        def convert(value, type)
          return value if (type.nil? or value.nil?)

          if type.is_a?(Array)
            return value.map {|item| convert(item, type.first) }
          elsif Object.children.include?(type)
            return type.new(value, client)
          else
            try_each(CONVERTERS[type]) do |converter|
              return converter.call(value)
            end
          end

          value
        end

        CONVERTERS = {
          String  => [proc {|value| String(value) }],
          Time    => [proc {|value| Time.at(Integer(value)) }, proc {|value| DateTime.parse(value).to_time }],
          Boolean => [proc {|value| Integer(value) == 1 }],
          Integer => [proc {|value| Integer(value) }],
          Float   => [proc {|value| Float(value) }],
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
