class Flickr
  class Photo < Media

    attribute :rotation,   Integer

    attribute :source_url, String
    attribute :height,     Integer
    attribute :width,      Integer

    attr_reader :size

    SIZES.keys.each do |size|
      size_name, size_number = size.split(" ").map(&:downcase)

      define_method("#{size_name}#{size_number}!") { @size = size; self }
      define_method("#{size_name}#{size_number}")  { dup.send("#{__method__}!") }

      if size_number
        define_method("#{size_name}!") { |size_number| send("#{size_name}#{size_number}!") }
        define_method("#{size_name}")  { |size_number| send("#{size_name}#{size_number}") }
      end

      define_method("#{size_name}#{size_number}_or_smaller!") do
        sizes = SIZES.keys.reverse.drop_while { |s| s != size }
        @size = sizes.find { |s| @hash["url_#{SIZES[s]}"] }
        self
      end
      define_method("#{size_name}#{size_number}_or_smaller") { dup.send("#{__method__}!") }

      define_method("#{size_name}#{size_number}_at_least!") do
        sizes = SIZES.keys.drop_while { |s| s != size }.reverse
        @size = sizes.find { |s| @hash["url_#{SIZES[s]}"] }
        self
      end
      define_method("#{size_name}#{size_number}_at_least") { dup.send("#{__method__}!") }
    end

    def largest!; @size = largest_size; self end
    def largest;  dup.largest!               end
  end
end
