require_relative "attribute_values/collection"

class Flickr
  class Collection < Object
    include Enumerable

    attribute :current_page,  Integer
    attribute :per_page,      Integer
    attribute :total_pages,   Integer
    attribute :total_entries, Integer

    def initialize(collection, klass, hash, client)
      unless klass == Media
        objects = collection.map! do |hash|
          klass.new(hash, client)
        end
      else
        objects = collection.map! do |hash|
          klass = Flickr.const_get(hash["media"].capitalize)
          klass.new(hash, client)
        end
      end

      @hash = hash
      @objects = objects
    end

    def find(id = nil)
      if block_given?
        super
      else
        if id.is_a?(Array)
          ids = id.map(&:to_s)
          select { |object| ids.include?(object.id) }
        else
          super() { |object| object.id == id.to_s }
        end
      end
    end

    def each(&block)
      @objects.each(&block)
    end

    def empty?
      @objects.empty?
    end

    def select!(*args, &block)
      @objects.select!(*args, &block)
      self
    end

    def select(*args, &block)
      dup.select!(*args, &block)
    end
  end
end
