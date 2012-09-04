class Flickr
  class Object
    def self.find(id)
      new(id: id)
    end

    def self.inherited(child)
      child.send(:include, ApiCaller)
    end

    protected

    def initialize(attributes = {})
      assign_attributes(attributes)
      @client = self.class.instance_variable_get("@client")
    end

    def update_attributes(attributes)
      assign_attributes(attributes)
    end

    private

    def assign_attributes(attributes)
      attributes.each do |name, value|
        if respond_to?(name)
          instance_variable_set("@#{name}", value)
        else
          raise ArgumentError, "unknown attribute '#{name}'"
        end
      end
    end
  end
end

require "flickr/object/media"
require "flickr/object/photo"
require "flickr/object/video"
