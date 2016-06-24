module Flickr
  class Client

    ##
    # Client for uploading photos.
    #
    class Upload < Flickr::Client

      def initialize(access_token = nil)
        access_token ||= Array.new(2, nil)

        super() do |builder|
          # Request
          builder.use FaradayMiddleware::OAuth,
            consumer_key:    api_key,
            consumer_secret: shared_secret,
            token:           access_token[0],
            token_secret:    access_token[1]
          builder.use Faraday::Request::Multipart

          # Response
          builder.use Flickr::Middleware::CheckStatus
          builder.use FaradayMiddleware::ParseXml
          builder.use Flickr::Middleware::CheckOAuth
        end
      end

      def upload(params = {})
        params[:photo] = UploadIO(params[:photo])
        post "upload", params
      end

      def replace(params = {})
        params[:photo] = UploadIO(params[:photo])
        post "replace", params
      end

      private

      def UploadIO(file)
        io = Faraday::UploadIO.new(file.file, file.content_type, file.path)
        io.instance_eval { def length; size; end } # hack for multipart-post to support any IO
        io
      end

      def url
        "https://api.flickr.com/services"
      end

    end

  end
end
