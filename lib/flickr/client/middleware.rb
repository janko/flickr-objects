require "cgi"

class Flickr
  class Client < Faraday::Connection
    module Middleware
      class CheckStatus < Faraday::Response::Middleware
        def on_complete(env)
          env[:body] = env[:body]["rsp"] || env[:body]

          if env[:body]["stat"] != "ok"
            message = env[:body]["message"] || env[:body]["err"]["msg"]
            code = env[:body]["code"] || env[:body]["err"]["code"]
            raise ApiError.new(message, code)
          end
        end
      end

      class CheckOAuth < Faraday::Response::Middleware
        def on_complete(env)
          if env[:status] != 200
            message = CGI.parse(env[:body])["oauth_problem"].first
            pretty_message = message.gsub('_', ' ').capitalize
            raise OAuthError, pretty_message
          end
        end
      end

      # A copy from Faraday (credits to @mislav)
      class Retry < Faraday::Middleware
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
          rescue *@errmatch => error
            if retries > 0
              retries -= 1
              sleep @sleep if @sleep > 0
              retry
            end
            raise Flickr::TimeoutError, error.message
          end
        end
      end
    end
  end
end
