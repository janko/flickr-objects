class Flickr
  class Tag < Object
    def delete(params = {})
      client.post(params.merge(photo_id: @hash["photo_id"], tag_id: id))
      self
    end
    alias remove delete
  end
end
