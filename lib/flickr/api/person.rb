require "flickr/api/api_methods/person"

class Flickr
  class Person < Object
    def get_contacts_public_photos(params = {})
      get_contacts_public_media(params).select {|object| object.is_a?(Flickr::Photo) }
    end
    def get_contacts_public_videos(params = {})
      get_contacts_public_media(params).select {|object| object.is_a?(Flickr::Video) }
    end
    def get_contacts_public_media(params = {})
      response = client.get(params.merge(user_id: id, include_media: true))
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end
  end
end
