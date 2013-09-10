require "faraday"
require "faraday_middleware"
require "flickr/middleware"

module Flickr

  ##
  # This abstract class is the base for the client classes which communicate with
  # the Flickr API. For example, the part of Flickr API for uploading photos need
  # requests to be marked as multipart, while the part for querying data of photos
  # doesn't need it. So it's obvious that we need separate classes.
  #
  # This class just extracts the common behaviour, like including the API key
  # in requests.
  #
  # @private
  #
  class Client

    extend Flickr::AutoloadHelper

    autoload_dir "flickr/client",
      :Data   => "data",
      :Upload => "upload",
      :OAuth  => "oauth"

    DEFAULTS = {
      open_timeout: 8,
      timeout:      10,
    }

    def initialize
      @connection = Faraday.new(url, connection_options) do |builder|
        builder.use Flickr::Middleware::CatchTimeout
        yield builder if block_given?

        builder.adapter :net_http
      end
    end

    def get(*args, &block)
      do_request(:get, *args, &block)
    end

    def post(*args, &block)
      do_request(:post, *args, &block)
    end

    private

    def connection_options
      {
        params: {
          format: "json",
          nojsoncallback: 1,
          api_key: api_key,
        },
        request: {
          open_timeout: open_timeout,
          timeout: timeout,
        },
        proxy: proxy,
      }
    end

    def url
      # Should be implemented in subclasses
    end

    def do_request(http_method, *args, &block)
      response = @connection.send(http_method, *args, &block)
      response.body
    end

    def api_key
      Flickr.api_key
    end

    def shared_secret
      Flickr.shared_secret
    end

    def open_timeout
      Flickr.open_timeout || DEFAULTS[:open_timeout]
    end

    def timeout
      Flickr.timeout || DEFAULTS[:timeout]
    end

    def use_ssl?
      !!Flickr.use_ssl
    end

    def proxy
      Flickr.proxy
    end

  end

end
