class Flickr
  module ApiCaller
    def self.included(base)
      base.send(:include, ClientMethods) unless base == Flickr
      base.send(:extend, ApiMethods)
    end

    module ClientMethods
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.send(:extend, ClassMethods)
      end

      module InstanceMethods
        def client
          @client.for(self)
        end
      end

      module ClassMethods
        def client
          @client.for(self)
        end
      end
    end

    module ApiMethods
      def instance_api_method(method, flickr_method)
        Flickr.api_methods[flickr_method] << "#{self.name}##{method}"

        if respond_to?(:children)
          children.each { |child| Flickr.api_methods[flickr_method] << "#{child.name}##{method}" }
        end
      end

      def class_api_method(method, flickr_method)
        Flickr.api_methods[flickr_method] << "#{self.name}.#{method}"

        if respond_to?(:children)
          children.each { |child| Flickr.api_methods[flickr_method] << "#{child.name}.#{method}" }
        end
      end
    end
  end
end
