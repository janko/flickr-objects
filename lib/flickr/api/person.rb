class Flickr
  class Person < Object
    def get_public_photos_from_contacts(params = {})
      get_public_media_from_contacts(params).select {|object| object.is_a?(Flickr::Photo) }
    end
    def get_public_videos_from_contacts(params = {})
      get_public_media_from_contacts(params).select {|object| object.is_a?(Flickr::Video) }
    end
    def get_public_media_from_contacts(params = {})
      response = client.get flickr_method(__method__), include_media(params.merge(user_id: id))
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end
    instance_api_method :get_public_photos_from_contacts, "flickr.photos.getContactsPublicPhotos"
    instance_api_method :get_public_videos_from_contacts, "flickr.photos.getContactsPublicPhotos"
    instance_api_method :get_public_media_from_contacts, "flickr.photos.getContactsPublicPhotos"
  end
end
