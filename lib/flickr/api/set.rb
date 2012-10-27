class Flickr
  class Set < Object
    def add_media(media_id, params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id, photo_id: media_id)
    end
    alias add_photo add_media
    alias add_video add_media
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
      response = client.get flickr_method(__method__), include_media(params.merge(photoset_id: id))
      Collection.new(response["photoset"].delete("photo"), Media, response["photoset"], client)
    end
    instance_api_method :get_photos, "flickr.photosets.getPhotos"
    instance_api_method :get_videos, "flickr.photosets.getPhotos"
    instance_api_method :get_media,  "flickr.photosets.getPhotos"

    def remove_media(media_id, params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id, photo_ids: media_id)
    end
    alias remove_photos remove_media
    alias remove_videos remove_media
    instance_api_method :remove_media,  "flickr.photosets.removePhotos"
    instance_api_method :remove_photos, "flickr.photosets.removePhotos"
    instance_api_method :remove_videos, "flickr.photosets.removePhotos"

    alias remove_photo remove_media
    alias remove_video remove_media
    instance_api_method :remove_media, "flickr.photosets.removePhoto"
    instance_api_method :remove_photo, "flickr.photosets.removePhoto"
    instance_api_method :remove_video, "flickr.photosets.removePhoto"
  end
end
