class Flickr
  class MethodsClient < Client
    def initialize(access_token)
      super(access_token)
    end

    def for(owner)
      @owner_prefix = (owner.instance_of?(Class) ? "#{owner}." : "#{owner.class}#")
      self
    end

    [:get, :post].each do |http_method|
      define_method(http_method) do |method_name, params = {}|
        flickr_method = resolve_flickr_method(method_name)
        fix_extras(params)

        response = super("rest") do |req|
          req.params[:method] = flickr_method
          req.params.update(params)
        end

        response.body
      end
    end

    private

    def parser
      FaradayMiddleware::ParseJson
    end

    def resolve_flickr_method(method_name)
      full_method_name = "#{@owner_prefix}#{method_name}"
      pair = Flickr.api_methods.find { |_, value| value.include?(full_method_name) }

      if pair
        pair.first
      else
        raise "method #{full_method_name} not found"
      end
    end

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
