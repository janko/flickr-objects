class Flickr
  extend ApiCaller::ApiMethods

  self.class_api_methods = {
    test_login: "flickr.test.login",
    test_echo: "flickr.test.echo",
    test_null: "flickr.test.null"
  }

  self.instance_api_methods = class_api_methods
end
