module Flickr
  class Client

    ##
    # Client for query and maniuplation of Flickr's photo data.
    #
    class Data < Flickr::Client

      def initialize(access_token = nil)
        access_token ||= Array.new(2, nil)

        super() do |builder|
          # Request
          builder.use FaradayMiddleware::OAuth,
            consumer_key:    api_key,
            consumer_secret: shared_secret,
            token:           access_token[0],
            token_secret:    access_token[1]

          # Response
          builder.use Flickr::Middleware::CheckStatus
          builder.use FaradayMiddleware::ParseJson
          builder.use Flickr::Middleware::CheckOAuth
        end
      end

      private

      def do_request(http_method, flickr_method, params = {})
        super(http_method, "rest") do |req|
          req.params[:method] = flickr_method
          req.params.update(params)
        end
      end

      def url
        "https://api.flickr.com/services"
      end

    end

  end
end
