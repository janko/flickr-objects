require "flickr/objects/attribute_values/media"
require "flickr/api/media"

class Flickr
  class Media < Object

    attribute :id,                   type: String
    attribute :secret,               type: String
    attribute :server,               type: String
    attribute :farm,                 type: Integer
    attribute :title,                type: String
    attribute :description,          type: String
    attribute :license,              type: Integer
    attribute :safety_level,         type: Integer
    attribute :visibility,           type: Visibility

    attribute :owner,                type: Person

    attribute :uploaded_at,          type: Time
    attribute :posted_at,            type: Time
    attribute :taken_at,             type: Time
    attribute :taken_at_granularity, type: Integer
    attribute :updated_at,           type: Time

    attribute :views_count,          type: Integer
    attribute :comments_count,       type: Integer

    attribute :editability,          type: Permissions
    attribute :public_editability,   type: Permissions
    attribute :usage,                type: Permissions

    attribute :notes,                type: Array(Note)
    attribute :tags,                 type: Array(Tag)

    attribute :has_people?,          type: Boolean
    attribute :favorite?,            type: Boolean

    attribute :path_alias

    attribute :location,             type: Location
    attribute :location_visibility,  type: Visibility

    def safe?;       safety_level <= 1 if safety_level end
    def moderate?;   safety_level == 2 if safety_level end
    def restricted?; safety_level == 3 if safety_level end

    def url
      if owner
        "http://www.flickr.com/photos/#{owner.id}/#{id}/"
      end
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

    def largest_size
      SIZES.key(SIZES.values.reverse.find { |abbr| @hash["url_#{abbr}"] })
    end

    def self.new(hash, client)
      if self == Media && hash["media"]
        klass = Flickr.const_get(hash["media"].capitalize)
        klass.new(hash, client)
      else
        super
      end
    end

    private

    def size_abbr(size = @size)
      SIZES[size]
    end
  end
end
