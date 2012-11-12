require_relative "api_methods/photo"

class Flickr
  class Photo < Media
    def self.get_from_contacts(params = {})
      super(params).select { |media| media.is_a?(self) }
    end

    def self.search(params = {})
      super(params.merge(media: "photos"))
    end
  end
end
