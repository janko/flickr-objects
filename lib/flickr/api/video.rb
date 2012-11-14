class Flickr
  class Video < Media
    def self.get_from_contacts(params = {})
      super(params).select { |media| media.is_a?(self) }
    end

    def self.search(params = {})
      super(params.merge(media: "videos"))
    end
  end
end
