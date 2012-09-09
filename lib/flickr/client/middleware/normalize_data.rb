class Flickr
  class Client
    module Middleware
      class NormalizeData < Faraday::Response::Middleware
        def call(env)
          response = @app.call(env)
          normalize_data!(response)
        end

        private

        def normalize_data!(response)
          response.env[:body] = clean_data(response.env[:body])
          response
        end

        def clean_data(data)
          data.inject({}) do |hash, (key, value)|
            hash[key] =
              if value.is_a?(Hash)
                value.count == 1 ? (value["_content"] || clean_data(value)) : clean_data(value)
              else
                value
              end
            hash
          end
        end
      end
    end
  end
end
