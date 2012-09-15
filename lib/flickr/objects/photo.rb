require "flickr/objects/attribute_values/photo"

class Flickr
  class Photo < Media
    attr_reader :size

    attribute :rotation,   type: Integer
    attribute :source_url, type: String
    attribute :height,     type: String
    attribute :width,      type: String

    SIZES = {
      "Square 75"  => "sq",
      "Thumbnail"  => "t",
      "Square 150" => "q",
      "Small 240"  => "s",
      "Small 320"  => "n",
      "Medium 500" => "m",
      "Medium 640" => "z",
      "Medium 800" => "c",
      "Large 1024" => "l",
      "Large 1600" => "h",
      "Large 2048" => "k",
      "Original"   => "o"
    }

    SIZES.keys.each do |size|
      size_name, size_number = size.split(" ").map(&:downcase)

      define_method("#{size_name}#{size_number}!") { @size = size; self }
      define_method("#{size_name}#{size_number}")  { dup.send("#{size_name}#{size_number}!") }

      if size_number
        define_method("#{size_name}!") {|size_number| send("#{size_name}#{size_number}!") }
        define_method("#{size_name}")  {|size_number| send("#{size_name}#{size_number}") }
      end
    end

    def largest!; @size = largest_size; self end
    def largest;  dup.largest!               end

    def initialize(*args)
      super
      largest!
    end

    private

    def largest_size
      SIZES.key(SIZES.values.reverse.find { |abbr| @hash["url_#{abbr}"] })
    end

    def size_abbr
      SIZES[size]
    end
  end
end

require "flickr/api/photo"
