class Flickr
  class Media < Object
    register_api_methods!

    def get_info!(params = {})
      response = client.get(params.merge(photo_id: id))
      @hash.update(response["photo"])
      self
    end

    def set_content_type(value, params = {})
      client.post(params.merge(photo_id: id, content_type: value))
      value
    end
    alias content_type= set_content_type
  end
end
