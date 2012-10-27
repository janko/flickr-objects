class Flickr
  api_methods = proc do
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
      response = client.get flickr_method(__method__), include_media(params)
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end
    api_method :get_photos_from_contacts, "flickr.photos.getContactsPhotos"
    api_method :get_videos_from_contacts, "flickr.photos.getContactsPhotos"
    api_method :get_media_from_contacts,  "flickr.photos.getContactsPhotos"

    def test_login(params = {})
      client.get flickr_method(__method__), params
    end
    api_method :test_login, "flickr.test.login"

    def test_echo(params = {})
      client.get flickr_method(__method__), params
    end
    api_method :test_echo, "flickr.test.echo"

    def test_null(params = {})
      client.get flickr_method(__method__), params
    end
    api_method :test_null, "flickr.test.null"
  end

  def self.api_method(*args) class_api_method(*args) end
  instance_eval(&api_methods)

  def self.api_method(*args) instance_api_method(*args) end
  class_eval(&api_methods)
end
