require "flickr/api/api_methods/flickr"

class Flickr
  api_methods = Module.new do
    def upload(media, params = {})
      response = upload_client.upload(media, params)
      if params[:async] == 1
        response["ticketid"]
      else
        response["photoid"]
      end
    end

    def replace(media, id, params = {})
      response = upload_client.replace(media, id, params)
      if params[:async] == 1
        response["ticketid"]
      else
        response["photoid"]
      end
    end

    def get_photos_from_contacts(params = {})
      get_media_from_contacts(params).select { |media| media.is_a?(Photo) }
    end
    def get_videos_from_contacts(params = {})
      get_media_from_contacts(params).select { |media| media.is_a?(Video) }
    end
    def get_media_from_contacts(params = {})
      response = client.get(params.merge(include_media: true))
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end

    def test_login(params = {})
      response = client.get(params)
      Person.new(response["user"], client)
    end

    def test_echo(params = {})
      client.get(params)
    end

    def test_null(params = {})
      client.get(params)
    end
  end

  include api_methods
  extend  api_methods
end
