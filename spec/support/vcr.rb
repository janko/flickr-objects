class Flickr
  class Client
    attr_writer :automatic_vcr
    def automatic_vcr
      @automatic_vcr ||= true
    end

    [:get, :post].each do |http_method|
      normal_method = instance_method(http_method)
      define_method(http_method) do |*args, &block|
        path = args.first
        req = Struct.new(:params).new({})
        req.params = args.last.is_a?(Hash) ? args.last : {}
        block.call(req) if block
        if path == "rest"
          cassette_name = req.params[:vcr] || req.params[:method]
        else
          cassette_name = req.params[:vcr] || "upload"
        end

        debugger if cassette_name.nil?
        if automatic_vcr
          VCR.use_cassette cassette_name do
            normal_method.bind(self).call(*args, &block)
          end
        end
      end
    end
  end
end
