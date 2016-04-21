module Flickr
  module Api

    class License < Abstract

      ##
      # @param params [Hash] See documentation below
      # @return [Flickr::Object::List<Flickr::Object::License>]
      # @docs [flickr.photos.licenses.getInfo](https://www.flickr.com/services/api/flickr.photos.licenses.getInfo.html)
      #
      def all(params = {})
        response = get "photos.licenses.getInfo", params
        new_list(:License, response["licenses"]["license"])
      end

    end

  end
end
