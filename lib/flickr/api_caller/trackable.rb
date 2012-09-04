class Flickr
  module ApiCaller
    module Trackable
      def self.included(base)
        base.class_eval do
          extend Methods
          def self.singleton?; false end

          class << self
            extend Methods
            def self.singleton?; true end
          end
        end

        # This is needed so that we can know the name of the
        # underlying class of a singleton class
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          class << base
            def self.name
              #{base.name}
            end
          end
        RUBY
      end

      module Methods
        def api_method(method, api_method)
          if singleton?
            # A class method was registered
            Flickr.api_methods.add(api_method, "#{self.name}.#{method}")
          else
            # An instance method was registered
            Flickr.api_methods.add(api_method, "#{self.name}##{method}")
          end
        end
      end
    end
  end
end
