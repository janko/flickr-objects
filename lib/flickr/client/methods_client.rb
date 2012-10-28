class Flickr
  class MethodsClient < Client
    def initialize(access_token)
      super(access_token)
    end

    [:get, :post].each do |http_method|
      define_method(http_method) do |flickr_method, params = {}|
        response = super("rest") do |req|
          req.params[:method] = flickr_method
          req.params.update(params)
        end

        response.body
      end
    end

    def parser
      FaradayMiddleware::ParseJson
    end
  end
end
