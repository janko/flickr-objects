class Flickr
  module ApiCaller
    def self.included(base)
      base.send(:include, ClientMethods) unless base == Flickr
      base.register_api_methods
    end

    module ClientMethods
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.send(:extend,  ClassMethods)
        # Pass on the API methods to the children
        base.class_eval do
          children.each do |child|
            child.instance_api_methods = self.instance_api_methods.merge(child.instance_api_methods)
            child.class_api_methods = self.class_api_methods.merge(child.class_api_methods)
          end
        end
      end

      module InstanceMethods
        def client
          @client.for(self)
        end
      end

      module ClassMethods
        def client
          (@client || Flickr.client).for(self)
        end
      end
    end

    module ApiMethods
      attr_writer :class_api_methods, :instance_api_methods
      def class_api_methods;    @class_api_methods ||= {}    end
      def instance_api_methods; @instance_api_methods ||= {} end

      def register_api_methods
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
