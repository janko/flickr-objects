class Flickr
  class MethodsClient < Client
    def parser
      FaradayMiddleware::ParseJson
    end

    def initialize(access_token)
      super(access_token)
    end

    def for(scope)
      @scope = scope
      self
    end

    [:get, :post].each do |http_method|
      define_method(http_method) do |*args|
        flickr_method = args.first.is_a?(String) ? args.first : resolve_flickr_method
        params = args.last.is_a?(Hash) ? args.last : {}

        if params.delete(:include_sizes)
          urls = Flickr::Media::SIZES.values.map {|abbr| "url_#{abbr}" }.join(",")
          include_in_extras(params, urls)
        end
        if params.delete(:include_media)
          include_in_extras(params, "media")
        end

        response = super("rest") do |req|
          req.params[:method] = flickr_method
          req.params.update(params)
        end

        response.body
      end
    end

    private

    def resolve_flickr_method
      method_name = caller[1][/(?<=`).+(?='$)/]
      full_method_name = if @scope.instance_of?(Class)
                           "#{@scope}.#{method_name}"
                         else
                           "#{@scope.class}##{method_name}"
                         end
      pair = Flickr.api_methods.find { |_, value| value.include?(full_method_name) }

      if pair
        pair.first
      else
        raise "method #{full_method_name} not found"
      end
    end

    def include_in_extras(params, things)
      params[:extras] = [params[:extras], things].compact.join(",")
    end
  end
end
