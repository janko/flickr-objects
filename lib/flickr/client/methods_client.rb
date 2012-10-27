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

    private

    def fix_extras(params)
      if params.delete(:include_sizes)
        urls = Flickr::Media::SIZES.values.map {|abbr| "url_#{abbr}" }.join(",")
        include_in_extras(params, urls)
      end
      if params.delete(:include_media)
        include_in_extras(params, "media")
      end
    end

    def include_in_extras(params, things)
      params[:extras] = [params[:extras], things].compact.join(",")
    end
  end
end
