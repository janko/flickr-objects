class Flickr
  module ApiCaller
    def self.included(base)
      base.send(:include, ClientMethods)
      base.send(:extend, ApiMethods)
    end

    module ClientMethods
      def self.included(base)
        unless base == Flickr
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
    end

    module ApiMethods
      attr_reader :class_api_methods
      def class_api_methods=(hash)
        @class_api_methods = hash
        if respond_to?(:children)
          children.each {|child| child.class_api_methods = self.class_api_methods }
        end
      end
      attr_reader :instance_api_methods
      def instance_api_methods=(hash)
        @instance_api_methods = hash
        if respond_to?(:children)
          children.each {|child| child.instance_api_methods = self.instance_api_methods }
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
