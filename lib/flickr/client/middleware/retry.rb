class Flickr
  class Client < Faraday::Connection
    module Middleware
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
    end
  end
end
