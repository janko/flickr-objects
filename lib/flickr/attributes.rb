require "date"

module Flickr

  ##
  # A helper class for true/false type.
  #
  # @private
  #
  class Boolean
  end

  ##
  # A module that provides functionality of defining attributes of which locations
  # can be found in the JSON response from Flickr.
  #
  # @private
  #
  module Attributes

    ##
    # Registers an attribute (name + type), defining the getter method (and in the
    # boolean case an additional predicated alias).
    #
    def attribute(name, type)
      new_attribute = Attribute.new(name, type)

      attributes << new_attribute

      define_method(name) do
        self.class.attributes.find(name).value(self)
      end
      alias_method "#{name}?", name if type == Boolean

      new_attribute
    end

    ##
    # List of all registered attributes.
    #
    def attributes
      @attributes ||= AttributeSet.new
    end

  end

  ##
  # This class stores the information about attributes. It stores the name, locations
  # and type, and it is responsible for retrieving the attribute values from Flickr's
  # JSON response, and optionally coercing them to the right type (for example, time
  # can be represented in JSON only as a string, and here we convert it to actual
  # instance of Ruby's `Time` class).
  #
  # @private
  #
  class Attribute

    attr_reader :name, :type, :locations

    def initialize(name, type)
      @name, @type = name, type
      @locations = []
    end

    def add_locations(locations)
      @locations = locations + @locations
    end

    def value(object)
      value = find_value(object)
      coerce(value, object, @type)
    end

    private

    ##
    # Finds attribute value in the JSON response by looking at the given locations.
    #
    def find_value(context)
      locations.each do |location|
        begin
          value = context.instance_exec(&location)
          next if value.nil?
          return value
        rescue
        end
      end

      nil
    end

    ##
    # It coerces the found attribute value into a given type. For example, "boolean"
    # type is represented in JSON as an integer (1/0), so values of this type need to
    # be coerced the appropriate true/false values.
    #
    def coerce(value, object, type)
      return value if value.nil?

      if type.is_a?(Enumerable)
        objects = value.map { |e| coerce(e, object, type.first) }
        if type.respond_to?(:find_by)
          return type.class.new({}).populate(objects)
        else
          return type.class.new(objects)
        end
      elsif type.ancestors.include? Flickr::Object
        return type.new(value, object.access_token)
      else
        COERCIONS.fetch(type).each do |coercion|
          begin
            return coercion.call(value)
          rescue
          end
        end
      end

      value
    end

    COERCIONS = {

      String => [
        ->(value) { String(value) },
      ],

      Time => [
        ->(value) { Time.at(Integer(value)) },
        ->(value) { DateTime.parse(value).to_time },
      ],

      Boolean => [
        ->(value) { Integer(value) == 1 },
      ],

      Integer => [
        ->(value) { Integer(value) },
      ],

      Float => [
        ->(value) { Float(value) },
      ],

      Hash => [
        ->(value) { value },
      ],

      Array => [
        ->(value) { Array(value) },
      ]

    }

  end

  ##
  # Container for the attributes.
  #
  # @private
  #
  class AttributeSet

    include Enumerable

    def initialize(*attributes)
      @attributes = Array.new(attributes)
    end

    def each(*args, &block)
      @attributes.each(*args, &block)
    end

    ##
    # Shorthand for finding attributes by name.
    #
    def find(name = nil)
      if name
        super() { |attribute| attribute.name == name }
      else
        super()
      end
    end

    ##
    # Shorthand for adding locations to multiple attributes at once.
    #
    def add_locations(hash)
      hash.each do |attribute_name, locations|
        find(attribute_name).add_locations(locations)
      end
    end

    def <<(attribute)
      @attributes << attribute
      self
    end

  end

end
