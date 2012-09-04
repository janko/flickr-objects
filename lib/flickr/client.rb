require "faraday"
require "faraday_middleware"

class Flickr
  class Client < Faraday::Connection
    DEFAULTS = {
      open_timeout: 3,
      timeout: 4
    }

    def initialize(access_token)
      api_key, shared_secret = Flickr.configuration.fetch(:api_key, :shared_secret)

      open_timeout = Flickr.configuration.open_timeout || DEFAULTS[:open_timeout]
      timeout      = Flickr.configuration.timeout      || DEFAULTS[:timeout]

      params = {
        url: 'http://api.flickr.com/services/rest',
        params: {
          format: 'json',
          nojsoncallback: '1',
          api_key: api_key
        },
        request: {
          open_timeout: open_timeout,
          timeout: timeout
        }
      }

      super(params) do |builder|
        # Request
        builder.use Middleware::Retry
        builder.use FaradayMiddleware::OAuth,
          consumer_key: api_key,
          consumer_secret: shared_secret,
          token: access_token.first,
          token_secret: access_token.last

        # Response
        builder.use Middleware::StatusCheck
        builder.use FaradayMiddleware::ParseJson
        builder.use Middleware::OAuthCheck

        builder.adapter :net_http
      end
    end

    [:get, :post].each do |http_method|
      define_method(http_method) do |flickr_method, params = {}|
        super() do |req|
          req.params[:method] = flickr_method
          req.params.update(params)
        end
      end
    end
  end
end

require "flickr/client/middleware"
