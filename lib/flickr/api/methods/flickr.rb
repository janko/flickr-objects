class Flickr
  extend ApiCaller::ApiMethods

  self.class_api_methods = {
    test_login: "flickr.test.login"
  }

  self.instance_api_methods = class_api_methods
end
