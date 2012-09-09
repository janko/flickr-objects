class Flickr
  include ApiCaller

  methods = Module.new {
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
  }

  include methods
  extend  methods
end
