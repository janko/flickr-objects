require "flickr/attributes"

module Flickr

  ##
  # Every Flickr object inherits from this class. It provides interface for defining
  # attributes and some helper methods.
  #
  class Object

    extend Flickr::Attributes
    extend Flickr::AutoloadHelper

    autoload_names \
      :List, :Photo, :Person, :Set, :UploadTicket, :Permissions, :Location,
      :Visibility, :License

    ##
    # Overriding Flickr::Attributes#attribute to add a default location.
    # This means that `:<attribute>` will always first be searched in
    # `@attributes["<attribute>"]`.
    #
    # @!macro [attach] attribute
    #   @attribute [r] $1
    #   @return [$2]
    #
    # @private
    #
    def self.attribute(name, type)
      new_attribute = super
      new_attribute.add_locations([-> { @attributes[name.to_s] }])
    end

    ##
    # @private
    #
    def initialize(attributes, access_token = [])
      raise ArgumentError, "attributes should not be nil" if attributes.nil?

      @attributes = attributes
      @access_token = access_token
    end

    ##
    # @private
    #
    attr_reader :access_token
    ##
    # The raw hash of attributes returned from Flickr.
    #
    # @return [Hash]
    # @see #[]
    #
    attr_reader :attributes

    ##
    # Shorthand for accessing the raw hash of attributes returned
    # from Flickr.
    #
    # @see #attributes
    #
    def [](key)
      @attributes[key]
    end

    ##
    # Compares by ID (if that object has an ID), otherwise compares by attributes.
    #
    def ==(other)
      if not other.is_a?(Flickr::Object)
        raise ArgumentError "can't compare Flickr::Object with #{other.class}"
      end

      if [self, other].all? { |object| object.respond_to?(:id) && object.id }
        self.id == other.id
      else
        self.attributes == other.attributes
      end
    end
    alias eql? ==

    ##
    # Displays all the attributes and their values.
    #
    def inspect
      attribute_values = self.class.attributes
        .inject({}) { |hash, attribute| hash.update(attribute.name => send(attribute.name)) }
        .reject { |name, value| value.nil? or (value.respond_to?(:empty?) and value.empty?) }
      attributes = attribute_values
        .map { |name, value| "#{name}=#{value.inspect}" }
        .join(" ")

      class_name = self.class.name
      hex_code = "0x#{(object_id >> 1).to_s(16)}"

      "#<#{class_name}:#{hex_code} #{attributes}>"
    end

    ##
    # Tests if the object matches a hash of attributes. Supports nesting
    # (see the example).
    #
    # @param attributes [Hash]
    # @return [Boolean]
    # @example
    #   photo.matches?(owner: {username: "janko"})
    #
    def matches?(attributes)
      attributes.all? do |name, value|
        if send(name).is_a?(Flickr::Object) and value.is_a?(Hash)
          send(name).matches?(value)
        else
          send(name) == value
        end
      end
    end

    ##
    # @private
    #
    def update(attributes)
      @attributes.update(attributes)
      self
    end

    private

    def api
      api_name = self.class.name.match(/^Flickr::Object::/).post_match
      api_class = Flickr::Api.const_get(api_name)
      api_class.new(@access_token)
    end
  end

end
