class Flickr
  module ApiCaller

    def self.included(base)
      base.send(:include, ClientMethods) unless base == Flickr
      base.send(:include, ApiMethods)
      base.send(:include, ParamsFixingMethods)
    end

    module ClientMethods
      def self.included(base)
        base.send(:include, Methods)
        base.send(:extend,  Methods)
      end

      module Methods
        attr_reader :client
      end
    end

    module ApiMethods
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def instance_api_method(method, flickr_method)
          Flickr.api_methods[flickr_method] << "#{self.name}##{method}"
          children.each { |child| Flickr.api_methods[flickr_method] << "#{child.name}##{method}" } if respond_to?(:children)
        end

        def class_api_method(method, flickr_method)
          Flickr.api_methods[flickr_method] << "#{self.name}.#{method}"
          children.each { |child| Flickr.api_methods[flickr_method] << "#{child.name}.#{method}" } if respond_to?(:children)
        end

        def flickr_method(method_name)
          resolve_flickr_method("#{self.name}.#{method_name}")
        end

        def resolve_flickr_method(full_method_name)
          pair = Flickr.api_methods.find { |key, value| value.include?(full_method_name) }
          pair.first

        rescue NoMethodError
          raise "method #{full_method_name} is not registered"
        end
      end

      module InstanceMethods
        def flickr_method(method_name)
          self.class.resolve_flickr_method("#{self.class.name}##{method_name}")
        end
      end
    end

    module ParamsFixingMethods
      def self.included(base)
        base.send(:include, Methods)
        base.send(:extend,  Methods)
      end

      module Methods
        def include_media(params)
          params.dup.tap do |params|
            params[:extras] = [params[:extras], "media"].compact.join(",")
          end
        end
      end
    end

  end
end
