class Flickr
  module ApiCaller
    module ClientMethods
      def self.included(base)
        base.class_eval do
          def client
            @client.for(self)
          end

          def self.client
            (@client || Flickr.client).for(self)
          end
        end
      end
    end

    module ApiMethods
      def class_api_methods; @class_api_methods ||= {} end
      def class_api_methods=(hash)
        @class_api_methods = hash
        children.each do |child|
          child.class_api_methods = self.class_api_methods.merge(child.class_api_methods)
        end
      end

      def instance_api_methods; @instance_api_methods ||= {} end
      def instance_api_methods=(hash)
        @instance_api_methods = hash
        children.each do |child|
          child.instance_api_methods = self.instance_api_methods.merge(child.instance_api_methods)
        end
      end

      def register_api_methods!
        class_api_methods.each do |method, flickr_method|
          Flickr.api_methods[flickr_method] << "#{name}.#{method}"
        end
        instance_api_methods.each do |method, flickr_method|
          Flickr.api_methods[flickr_method] << "#{name}##{method}"
        end
      end
    end
  end
end
