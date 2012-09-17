require "cgi"
require "flickr/client/middleware/retry"

class Flickr
  class Client < Faraday::Connection
    module Middleware
      class CheckOAuth < Faraday::Response::Middleware
        def on_complete(env)
          if env[:status] != 200
            message = CGI.parse(env[:body])["oauth_problem"].first
            pretty_message = message.gsub('_', ' ').capitalize
            raise OAuthError, pretty_message
          end
        end
      end

      class CheckStatus < Faraday::Response::Middleware
        def on_complete(env)
          env[:body] = env[:body]["rsp"] || env[:body]

          if env[:body]["stat"] != "ok"
            message = env[:body]["message"] || env[:body]["err"]["msg"]
            code = env[:body]["code"] || env[:body]["err"]["code"]
            raise Error.new(message, code)
          end
        end
      end
    end

    class OAuthError < ArgumentError
    end

    class Error < StandardError
      attr_reader :code

      def initialize(message, code = nil)
        super(message)
        @code = code.to_i
      end
    end
  end
end
