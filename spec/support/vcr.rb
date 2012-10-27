require "vcr"

class Flickr
  class MethodsClient
    [:get, :post].each do |http_method|
      alias_method :"old_#{http_method}", :"#{http_method}"
      define_method(http_method) do |flickr_method, params = {}|
        VCR.use_cassette flickr_method do
          send("old_#{http_method}", flickr_method, params)
        end
      end
    end
  end

  class UploadClient
    [:get, :post].each do |http_method|
      alias_method :"old_#{http_method}", :"#{http_method}"
      define_method(http_method) do |*args, &block|
        VCR.use_cassette "upload" do
          send("old_#{http_method}", *args, &block)
        end
      end
    end
  end
end
