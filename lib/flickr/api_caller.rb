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
        def instance_api_method(method, flickr_method, options = {})
          [method, *options[:aliases]].each do |method|
            Flickr.api_methods[flickr_method] << "#{self.name}##{method}"
          end
          children.each { |child| Flickr.api_methods[flickr_method] << "#{child.name}##{method}" } if respond_to?(:children)
        end

        def class_api_method(method, flickr_method, options = {})
          [method, *options[:aliases]].each do |method|
            Flickr.api_methods[flickr_method] << "#{self.name}.#{method}"
          end
          children.each { |child| Flickr.api_methods[flickr_method] << "#{child.name}.#{method}" } if respond_to?(:children)
        end

        def api_method(*args)
          instance_api_method(*args)
          class_api_method(*args)
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
        def handle_extras(params)
          include_sizes(include_media(params))
        end

        def include_media(params)
          include_in_extras(params, "media")
        end

        def include_sizes(params)
          return params if params[:sizes].nil?

          abbrs = case params[:sizes]
                  when :all
                    Media::SIZES.values
                  else
                    params[:sizes].map { |size| Media::SIZES[size] }
                  end
          urls = abbrs.map { |abbr| "url_#{abbr}" }.join(",")
          include_in_extras(params, urls)
        end

        def include_in_extras(params, things)
          params.dup.tap do |params|
            params[:extras] = [params[:extras], things].compact.join(",")
          end
        end
      end
    end

  end
end
