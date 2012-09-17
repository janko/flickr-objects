require "flickr/api/api_methods/media"

class Flickr
  class Media < Object
    def add_tags(tags, params = {})
      client.post(params.merge(photo_id: id, tags: tags))
      tags
    end

    def delete(params = {})
      client.post(params.merge(photo_id: id))
      self
    end

    def get_info!(params = {})
      response = client.get(params.merge(photo_id: id))
      @hash.update(response["photo"])
      self
    end

    def remove_tag(tag, params = {})
      client.post(params.merge(photo_id: id, tag_id: (tag.respond_to?(:id) ? tag.id : tag)))
      tag
    end

    def self.search(params = {})
      response = client.get(params.merge(include_media: true))
      Collection.new(response["photos"].delete("photo"), self, response["photos"], client)
    end

    def set_content_type(value, params = {})
      client.post(params.merge(photo_id: id, content_type: value))
      value
    end
    alias content_type= set_content_type

    def set_tags(tags, params = {})
      client.post(params.merge(photo_id: id, tags: tags))
      tags
    end
    alias tags= set_tags
  end
end
