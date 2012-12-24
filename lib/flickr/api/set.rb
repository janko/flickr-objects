class Flickr
  class Set < Object
    def self.create(params = {})
      response = client.post f(__method__), params
      new(response["photoset"], client)
    end

    def self.delete(id, params = {})
      find(id).delete(params)
    end

    def delete(params = {})
      client.post f(__method__), params.merge(photoset_id: id)
      self
    end

    def edit_photos(params = {})
      client.post f(__method__), params.merge(photoset_id: id)
      self
    end

    def get_info!(params = {})
      response = client.get f(__method__), params.merge(photoset_id: id)
      @hash.update(response["photoset"])
      self
    end

    def get_photos(params = {})
      response = client.get f(__method__), handle_extras(params.merge(photoset_id: id))
      Photo.new_collection(response["photoset"].delete("photo"), client, response["photoset"])
    end

    def add_photo(photo_id, params = {})
      client.post f(__method__), params.merge(photoset_id: id, photo_id: photo_id)
    end

    def remove_photos(photo_ids, params = {})
      client.post f(__method__), params.merge(photoset_id: id, photo_ids: photo_ids)
    end

    def remove_photo(photo_id, params = {})
      client.post f(__method__), params.merge(photoset_id: id, photo_id: photo_id)
    end
  end
end
