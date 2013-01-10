require_relative "api_methods/photo"

class Flickr
  class Photo < Object
    def self.search(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def self.get_from_contacts(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def self.delete(id, params = {})
      find(id).delete(params)
    end

    def self.get_not_in_set(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def self.get_recent(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def self.get_untagged(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def self.get_with_geo_data(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def self.get_without_geo_data(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def self.get_recently_updated(params = {})
      response = client.get f(__method__), handle_extras(params)
      new_list(response["photos"].delete("photo"), client, response["photos"])
    end

    def get_info!(params = {})
      response = client.get f(__method__), params.merge(photo_id: id)
      @hash.update(response["photo"])
      self
    end

    def get_sizes!(params = {})
      response = client.get f(__method__), params.merge(photo_id: id)
      @hash.update(response["sizes"])
      self
    end

    def get_exif!(params = {})
      response = client.get f(__method__), params.merge(photo_id: id)
      @hash.update(response["photo"])
      self
    end

    def get_favorites(params = {})
      response = client.get f(__method__), params.merge(photo_id: id)
      Person.new_list(response["photo"].delete("person"), client, response["photo"])
    end

    def delete(params = {})
      client.post f(__method__), params.merge(photo_id: id)
      self
    end

    def set_content_type(content_type, params = {})
      client.post f(__method__), params.merge(photo_id: id, content_type: content_type)
      content_type
    end
    alias content_type= set_content_type

    def set_tags(tags, params = {})
      client.post f(__method__), params.merge(photo_id: id, tags: tags)
      tags
    end
    alias tags= set_tags

    def add_tags(tags, params = {})
      client.post f(__method__), params.merge(photo_id: id, tags: tags)
      tags
    end

    def remove_tag(tag_id, params = {})
      client.post f(__method__), params.merge(photo_id: id, tag_id: tag_id)
      tag_id
    end

    def set_dates(params = {})
      client.post f(__method__), params.merge(photo_id: id)
      params
    end

    def set_meta(params = {})
      client.post f(__method__), params.merge(photo_id: id)
      params
    end

    def set_permissions(params = {})
      client.post f(__method__), params.merge(photo_id: id)
      params
    end

    def set_safety_level(params = {})
      client.post f(__method__), params.merge(photo_id: id)
      params
    end
  end
end
