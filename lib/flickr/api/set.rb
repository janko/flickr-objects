class Flickr
  class Set < Object
    def add_photo(media_id, params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id, photo_id: media_id)
    end
    alias add_video add_photo
    alias add_media add_photo
    instance_api_method :add_media, "flickr.photosets.addPhoto"
    instance_api_method :add_photo, "flickr.photosets.addPhoto"
    instance_api_method :add_video, "flickr.photosets.addPhoto"

    def self.create(params = {})
      response = client.post flickr_method(__method__), params
      new(response["photoset"], client)
    end
    class_api_method :create, "flickr.photosets.create"

    def delete(params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id)
      self
    end
    instance_api_method :delete, "flickr.photosets.delete"

    def edit_photos(params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id)
      self
    end
    alias edit_videos edit_photos
    alias edit_media edit_photos
    instance_api_method :edit_photos, "flickr.photosets.editPhotos"
    instance_api_method :edit_videos, "flickr.photosets.editPhotos"
    instance_api_method :edit_media,  "flickr.photosets.editPhotos"

    def get_info!(params = {})
      response = client.get flickr_method(__method__), params.merge(photoset_id: id)
      @hash.update(response["photoset"])
      self
    end
    instance_api_method :get_info!, "flickr.photosets.getInfo"

    def get_photos(params = {})
      get_media(params.merge(media: "photos"))
    end
    def get_videos(params = {})
      get_media(params.merge(media: "videos"))
    end
    def get_media(params = {})
      response = client.get flickr_method(__method__), handle_extras(params.merge(photoset_id: id))
      Collection.new(response["photoset"].delete("photo"), Media, response["photoset"], client)
    end
    instance_api_method :get_photos, "flickr.photosets.getPhotos"
    instance_api_method :get_videos, "flickr.photosets.getPhotos"
    instance_api_method :get_media,  "flickr.photosets.getPhotos"

    def remove_photos(media_id, params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id, photo_ids: media_id)
    end
    alias remove_media remove_photos
    alias remove_videos remove_photos
    instance_api_method :remove_media,  "flickr.photosets.removePhotos"
    instance_api_method :remove_photos, "flickr.photosets.removePhotos"
    instance_api_method :remove_videos, "flickr.photosets.removePhotos"

    alias remove_photo remove_photos
    alias remove_video remove_photos
    instance_api_method :remove_media, "flickr.photosets.removePhoto"
    instance_api_method :remove_photo, "flickr.photosets.removePhoto"
    instance_api_method :remove_video, "flickr.photosets.removePhoto"
  end
end
