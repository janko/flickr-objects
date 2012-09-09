class Flickr
  include ApiCaller

  methods = Module.new {
    def test_login(params = {})
      client.get(params)
    end
  }

  include methods
  extend  methods
end
