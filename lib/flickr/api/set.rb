require_relative "api_methods/set"

class Flickr
  class Set < Object
    def add_photo(media_id, params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id, photo_id: media_id)
    end
    alias add_video add_photo
    alias add_media add_photo

    def self.create(params = {})
      response = client.post flickr_method(__method__), params
      new(response["photoset"], client)
    end

    def delete(params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id)
      self
    end

    def edit_photos(params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id)
      self
    end
    alias edit_videos edit_photos
    alias edit_media edit_photos

    def get_info!(params = {})
      response = client.get flickr_method(__method__), params.merge(photoset_id: id)
      @hash.update(response["photoset"])
      self
    end

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

    def remove_photos(media_id, params = {})
      client.post flickr_method(__method__), params.merge(photoset_id: id, photo_ids: media_id)
    end
    alias remove_videos remove_photos
    alias remove_media remove_photos

    alias remove_photo remove_photos
    alias remove_video remove_photos
  end
end
