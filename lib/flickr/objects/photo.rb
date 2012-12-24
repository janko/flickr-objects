require "flickr/helpers/base_58"

class Flickr
  class Photo < Object

    attribute :id,                   String
    attribute :secret,               String
    attribute :server,               String
    attribute :farm,                 Integer
    attribute :title,                String
    attribute :description,          String
    attribute :license,              Integer
    attribute :visibility,           Visibility
    attribute :safety_level,         Integer

    attribute :owner,                Person

    attribute :uploaded_at,          Time
    attribute :posted_at,            Time
    attribute :taken_at,             Time
    attribute :taken_at_granularity, Integer
    attribute :updated_at,           Time

    attribute :views_count,          Integer
    attribute :comments_count,       Integer

    attribute :editability,          Permissions
    attribute :public_editability,   Permissions
    attribute :usage,                Permissions

    attribute :notes,                Array(Note)
    attribute :tags,                 Array(Tag)

    attribute :has_people?,          Boolean
    attribute :favorite?,            Boolean

    attribute :path_alias,           String

    attribute :location,             Location
    attribute :location_visibility,  Visibility

    attribute :rotation,             Integer

    attribute :largest_size,         String
    attribute :available_sizes,      Array(String)

    attribute :source_url,           String
    attribute :height,               Integer
    attribute :width,                Integer

    def safe?;       safety_level <= 1 end
    def moderate?;   safety_level == 2 end
    def restricted?; safety_level == 3 end

    def url
      "http://www.flickr.com/photos/#{owner.id}/#{id}/" if owner
    end

    include Base58
    def short_url
      "http://flic.kr/p/#{to_base58(id)}"
    end

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
