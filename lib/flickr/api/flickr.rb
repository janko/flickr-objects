require "flickr/api/api_methods/flickr"

class Flickr
  module ApiMethods
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

  include ApiMethods
  extend  ApiMethods

  remove_const :ApiMethods
end
