require "faraday"
require "faraday_middleware"
require "flickr/client/middleware"

class Flickr
  class Client < Faraday::Connection
    DEFAULTS = {
      open_timeout: 4,
      timeout: 6
    }

    def initialize(access_token)
      api_key, shared_secret = Flickr.configuration.fetch(:api_key, :shared_secret)

      open_timeout = Flickr.configuration.open_timeout || DEFAULTS[:open_timeout]
      timeout      = Flickr.configuration.timeout      || DEFAULTS[:timeout]

      url = Flickr.configuration.secure ? "https://secure.flickr.com/services" : "http://api.flickr.com/services"
      proxy = Flickr.configuration.proxy

      params = {
        url: url,
        params: {
          format: "json",
          nojsoncallback: 1,
          api_key: api_key
        },
        request: {
          open_timeout: open_timeout,
          timeout: timeout
        },
        proxy: proxy
      }

      super(params) do |builder|
        # Request
        builder.use Middleware::Retry
        builder.use FaradayMiddleware::OAuth,
          consumer_key: api_key,
          consumer_secret: shared_secret,
          token: access_token.first,
          token_secret: access_token.last
        yield builder if block_given?

        # Response
        builder.use Middleware::CheckStatus
        builder.use self.parser
        builder.use Middleware::CheckOAuth

        builder.adapter :net_http
      end
    end
  end
end

require "flickr/client/methods_client"
require "flickr/client/upload_client"
