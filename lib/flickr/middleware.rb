require "cgi"
require "faraday"
require "faraday_middleware/response_middleware"
require "flickr/error"

module Flickr

  ##
  # A place for some custom middlewares for the API requests, mostly for translating
  # Flickr errors into Ruby errors.
  #
  # @private
  #
  module Middleware

    ##
    # Translates `Faraday::Error::TimeoutError` into `Flickr::TimeoutError`.
    #
    # @raise Flickr::TimeoutError
    #
    class CatchTimeout
      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          @app.call(env)
        rescue Faraday::Error::TimeoutError
          raise Flickr::TimeoutError
        end
      end
    end

    ##
    # Checks for errors in responses from Flickr, in which case it raises a
    # `Flickr::ApiError` which contains the code and the message found in the response.
    #
    # It's a bit ugly because Flickr returns different error formats when uploading
    # than when querying, so we need to take care of all cases.
    #
    # @raise Flickr::ApiError
    #
    class CheckStatus < Faraday::Response::Middleware
      def on_complete(env)
        env[:body] = env[:body]["rsp"] || env[:body]

        if env[:body]["stat"] != "ok"
          message = env[:body]["message"] || env[:body]["err"]["msg"]
          code = env[:body]["code"] || env[:body]["err"]["code"]

          raise Flickr::ApiError.new(message, code)
        end
      end
    end

    ##
    # Checks for OAuth errors. They are in a different form than standard Flickr errors,
    # so a special middleware is required.
    #
    # @raise Flickr::OAuthError
    #
    class CheckOAuth < Faraday::Response::Middleware
      def on_complete(env)
        if env[:status] != 200
          message = CGI.parse(env[:body])["oauth_problem"].first
          pretty_message = message.gsub('_', ' ').capitalize
          raise Flickr::OAuthError, pretty_message
        end
      end
    end

    ##
    # Parses OAuth respones (which are in form of URL parameters). It subclasses
    # FaradayMiddleware's internal `ResponseMiddleware` class for convenient parsing.
    #
    class ParseOAuth < FaradayMiddleware::ResponseMiddleware
      define_parser do |body|
        CGI.parse(body).inject({}) do |hash, (key, value)|
          hash.update(key.to_sym => value.first)
        end
      end
    end

  end

end
