ATTRIBUTE_ASSERTIONS = Hash.new do |hash, object_class|
  hash[object_class] = Hash.new do |_, attribute_name|
    attribute_type = object_class.attributes.find(attribute_name).type

    if attribute_type.is_a?(Enumerable)
      if attribute_type.is_a?(Flickr::Object::List)
        -> { be_a_list_of(attribute_type.first) }
      else
        -> { be_a(attribute_type.class) }
      end
    elsif attribute_type.is_a?(Array)
      -> { be_a(Array) }
    elsif attribute_type == Flickr::Boolean
      -> { be_a_boolean }
    else
      -> { be_a(attribute_type) }
    end
  end
end

ATTRIBUTE_ASSERTIONS[Flickr::Object::Photo].update(
  path_alias:      -> { be_nil },
  available_sizes: -> { eq Flickr::Object::Photo::SIZES },
  largest_size:    -> { eq "Original" },
)

ATTRIBUTE_ASSERTIONS[Flickr::Object::Person].update(
  path_alias:      -> { be_nil },
)
