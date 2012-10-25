class Flickr
  def self.api_method(method, flickr_method)
    @registered_api_methods ||= []

    unless @registered_api_methods.include?(method)
      @registered_api_methods << method
      instance_api_method(method, flickr_method)
      class_api_method(method, flickr_method)
    end
  end

  instance_and_class_eval do
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
      response = client.get(__method__, params.merge(include_media: true))
      Collection.new(response["photos"].delete("photo"), Media, response["photos"], client)
    end
    api_method :get_photos_from_contacts, "flickr.photos.getContactsPhotos"
    api_method :get_videos_from_contacts, "flickr.photos.getContactsPhotos"
    api_method :get_media_from_contacts,  "flickr.photos.getContactsPhotos"

    def test_login(params = {})
      response = client.get(__method__, params)
      Person.new(response["user"], client)
    end
    api_method :test_login, "flickr.test.login"

    def test_echo(params = {})
      client.get(__method__, params)
    end
    api_method :test_echo, "flickr.test.echo"

    def test_null(params = {})
      client.get(__method__, params)
    end
    api_method :test_null, "flickr.test.null"
  end
end
