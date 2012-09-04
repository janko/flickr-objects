require "cgi"

class Flickr
  class Client
    module Middleware
      # A copy-paste from Faraday's master branch
      class Retry < Faraday::Middleware
        # Public: Initialize middleware
        #
        # Options:
        # max        - Maximum number of retries (default: 2).
        # interval   - Pause in seconds between retries (default: 0).
        # exceptions - The list of exceptions to handle. Exceptions can be
        #              given as Class, Module, or String. (default:
        #              [Errno::ETIMEDOUT, Timeout::Error, Error::TimeoutError])
        def initialize(app, options = {})
          super(app)
          @retries, options = options, {} if options.is_a? Integer
          @retries ||= options.fetch(:max, 2).to_i
          @sleep     = options.fetch(:interval, 0).to_f
          @errmatch  = options.fetch(:exceptions) { [Errno::ETIMEDOUT, 'Timeout::Error', Faraday::Error::TimeoutError] }
        end

        def call(env)
          retries = @retries
          begin
            @app.call(env)
          rescue *@errmatch
            if retries > 0
              retries -= 1
              sleep @sleep if @sleep > 0
              retry
            end
            raise
          end
        end
      end

      class OAuthCheck < Faraday::Response::Middleware
        def on_complete(env)
          if env[:status] != 200
            message = CGI.parse(env[:body])["oauth_problem"].first
            pretty_message = message.gsub('_', ' ').capitalize
            raise OAuthError, pretty_message
          end
        end
      end

      class StatusCheck < Faraday::Response::Middleware
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
