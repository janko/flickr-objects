class Flickr
  module InheritableAttrAccessor
    def inheritable_attr_accessor(*names)
      names.each do |name|
        attr_reader name

        define_method("#{name}=") do |value|
          instance_variable_set("@#{name}", value)
          if respond_to?(:children)
            children.each do |child|
              child.send("#{name}=", send(name))
            end
          end
        end
      end
    end
  end
end
