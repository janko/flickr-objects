require "cgi"
require "flickr/client/middleware/retry"
require "flickr/client/middleware/normalize_data"

class Flickr
  class Client
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
          if env[:body]['stat'] != 'ok'
            raise Error.new(env[:body]['message'], env[:body]['code'])
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
