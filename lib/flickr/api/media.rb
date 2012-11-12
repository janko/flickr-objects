require_relative "api_methods/media"

class Flickr
  class Media < Object
    def add_tags(tags, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, tags: tags)
      tags
    end

    def delete(params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id)
      self
    end

    def self.get_from_contacts(params = {})
      response = client.get flickr_method(__method__), handle_extras(params)
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end

    def get_info!(params = {})
      response = client.get flickr_method(__method__), params.merge(photo_id: id)
      @hash.update(response["photo"])
      self
    end

    def get_sizes!(params = {})
      response = client.get flickr_method(__method__), params.merge(photo_id: id)
      @hash.update(response["sizes"])
      self
    end

    def remove_tag(tag_id, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, tag_id: tag_id)
      tag_id
    end

    def self.search(params = {})
      response = client.get flickr_method(__method__), handle_extras(params)
      Collection.new(response["photos"].delete("photo"), self, response["photos"], client)
    end

    def set_content_type(content_type, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, content_type: content_type)
      content_type
    end
    alias content_type= set_content_type

    def set_tags(tags, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, tags: tags)
      tags
    end
    alias tags= set_tags
  end
end
