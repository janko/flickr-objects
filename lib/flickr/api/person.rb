require "flickr/api/api_methods/person"

class Flickr
  class Person < Object
    def get_public_photos_from_contacts(params = {})
      get_public_media_from_contacts(params).select {|object| object.is_a?(Flickr::Photo) }
    end
    def get_public_videos_from_contacts(params = {})
      get_public_media_from_contacts(params).select {|object| object.is_a?(Flickr::Video) }
    end
    def get_public_media_from_contacts(params = {})
      response = client.get(params.merge(user_id: id, include_media: true))
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end
  end
end
