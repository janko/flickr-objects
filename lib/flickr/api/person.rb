class Flickr
  class Person < Object
    def self.find_by_email(email, params = {})
      response = client.get flickr_method(__method__), params.merge(find_email: email)
      new(response["user"], client)
    end
    class_api_method :find_by_email, "flickr.people.findByEmail"

    def self.find_by_username(username, params = {})
      response = client.get flickr_method(__method__), params.merge(username: username)
      new(response["user"], client)
    end
    class_api_method :find_by_username, "flickr.people.findByUsername"

    def get_info!(params = {})
      response = client.get flickr_method(__method__), params.merge(user_id: id)
      @hash.update(response["person"])
      self
    end
    instance_api_method :get_info!, "flickr.people.getInfo"

    def get_photos(params = {})
      get_media(params).select { |object| object.is_a?(Flickr::Photo) }
    end
    def get_videos(params = {})
      get_media(params).select { |object| object.is_a?(Flickr::Video) }
    end
    def get_media(params = {})
      response = client.get flickr_method(__method__), include_media(params.merge(user_id: id))
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end
    instance_api_method :get_photos, "flickr.people.getPhotos"
    instance_api_method :get_videos, "flickr.people.getPhotos"
    instance_api_method :get_media,  "flickr.people.getPhotos"

    def get_public_photos(params = {})
      get_public_media(params).select { |object| object.is_a?(Flickr::Photo) }
    end
    def get_public_videos(params = {})
      get_public_media(params).select { |object| object.is_a?(Flickr::Video) }
    end
    def get_public_media(params = {})
      response = client.get flickr_method(__method__), include_media(params.merge(user_id: id))
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end
    instance_api_method :get_public_photos, "flickr.people.getPublicPhotos"
    instance_api_method :get_public_videos, "flickr.people.getPublicPhotos"
    instance_api_method :get_public_media,  "flickr.people.getPublicPhotos"

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
    instance_api_method :get_public_media_from_contacts,  "flickr.photos.getContactsPublicPhotos"
  end
end
