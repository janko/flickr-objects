class Flickr
  class Object
    module Attribute
      def self.extended(base)
        base.send(:include, InstanceMethods)
      end

      def attributes
        @attributes ||= []
      end

      def attribute(name, type = ::Object, options = {})
        attributes << name

        define_method(name) do
          value = attribute_finder.find(name)
          attribute_converter.convert(value, type)
        end

        Array(options[:aliases]).each do |alias_name|
          alias_method alias_name, name
        end
      end

      module InstanceMethods
        def attribute_finder
          Finder.new(self)
        end

        def attribute_converter
          Converter.new(self)
        end
      end

      attr_accessor :attribute_values
    end
  end
end

require_relative "attribute/finder"
require_relative "attribute/converter"
