require "flickr/sanitized_file"

module Flickr
  module Api

    class General < Abstract

      ##
      # @example
      #   photo = File.open("/path/to/dandelions.jpg")
      #   Flickr.upload(photo, title: "Dandelions")
      # @param photo [String, File, Rails, Sinatra] Photo to upload
      # @param params [Hash] See documentation below
      # @return [String] ID of the uploaded photo (if synchronous)
      # @return [String] ID of the upload ticket (if asynchronous). See {Flickr::Api::UploadTicket#check}.
      # @docs [Upload API](http://www.flickr.com/services/api/upload.api.html)
      # @docs [Asynchronous Uploading](https://www.flickr.com/services/api/upload.async.html)
      #
      def upload(photo, params = {})
        response = super params.merge(photo: SanitizedFile.new(photo))
        params[:async] == 1 ? response["ticketid"] : response["photoid"]
      end

      ##
      # @example
      #   photo = File.open("/path/to/dandelions.jpg")
      #   Flickr.replace(photo, photo_id, title: "Dandelions")
      # @param photo [String, File, Rails, Sinatra] Photo to upload
      # @param photo_id [String] ID of the photo which will be replaced
      # @param params [Hash] See documentation below
      # @return [String] ID of the uploaded photo (if synchronous)
      # @return [String] ID of the upload ticket (if asynchronous)
      # @docs [Replace API](http://www.flickr.com/services/api/replace.api.html)
      # @docs [Asynchronous Uploading](https://www.flickr.com/services/api/upload.async.html)
      #
      def replace(photo, photo_id, params = {})
        response = super params.merge(photo: SanitizedFile.new(photo), photo_id: photo_id)
        params[:async] == 1 ? response["ticketid"] : response["photoid"]["__content__"]
      end

      ##
      # @return [Array<String>]
      # @docs [flickr.reflection.getMethods](http://www.flickr.com/services/api/flickr.reflection.getMethods.html)
      #
      def get_methods(params = {})
        response = get "reflection.getMethods", params
        response["methods"]["method"].map { |hash| hash["_content"] }
      end

      ##
      # @return [Hash]
      # @docs [flickr.test.login](http://www.flickr.com/services/api/flickr.test.login.html)
      #
      def test_login(params = {})
        get "test.login", params
      end

      ##
      # @return [Hash]
      # @docs [flickr.test.echo](http://www.flickr.com/services/api/flickr.test.echo.html)
      #
      def test_echo(params = {})
        get "test.echo", params
      end

      ##
      # @return [Hash]
      # @docs [flickr.test.null](http://www.flickr.com/services/api/flickr.test.null.html)
      #
      def test_null(params = {})
        get "test.null", params
      end

    end

  end
end
