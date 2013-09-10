module Flickr
  class Client

    ##
    # Client for OAuth authentication.
    #
    class OAuth < Flickr::Client

      NO_CALLBACK = "oob".freeze

      def initialize(request_token = nil)
        request_token ||= Array.new(2, nil)

        super() do |builder|
          builder.use FaradayMiddleware::OAuth,
            consumer_key:    api_key,
            consumer_secret: shared_secret,
            token:           request_token[0],
            token_secret:    request_token[1]

          builder.use Flickr::Middleware::ParseOAuth
          builder.use Flickr::Middleware::CheckOAuth
        end
      end

      def get_request_token(params = {})
        params[:oauth_callback] ||= NO_CALLBACK
        get "request_token", params
      end

      def get_access_token(params = {})
        get "access_token", params
      end

      private

      def url
        "http://www.flickr.com/services/oauth"
      end

    end

  end
end
