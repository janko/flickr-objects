require "flickr/api_caller/trackable"

class Flickr
  module ApiCaller
    def self.included(base)
      base.class_eval do
        include Trackable

        def client
          self.class.client
        end

        def self.client
          @client || Flickr.client
        end
      end
    end
  end
end
