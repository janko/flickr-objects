class Flickr
  class List < Object
    include Enumerable

    attribute :current_page,  Integer
    attribute :per_page,      Integer
    attribute :total_pages,   Integer
    attribute :total_entries, Integer

    def initialize(objects, hash)
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

    def method_missing(name, *args, &block)
      if name.to_s =~ /find_by_\w+/
        attribute_name = name[/(?<=find_by_)\w+/]
        @objects.find { |object| object.send(attribute_name) == args.first }
      else
        super
      end
    end

  end
end
