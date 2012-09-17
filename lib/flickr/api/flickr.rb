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
