require "faraday"
require "faraday_middleware"

RSpec::Matchers.define :be_a_nonempty do |klass|
  match do |object|
    object.is_a?(klass) and not object.empty?
  end
end

RSpec::Matchers.define :be_an_empty do |klass|
  match do |object|
    object.is_a?(klass) and object.empty?
  end
end

RSpec::Matchers.define :be_a_boolean do
  match do |object|
    object == true or object == false
  end
end

RSpec::Matchers.define :be_a_list_of do |klass|
  match do |object|
    object.is_a?(Flickr::Object::List) and object.first.is_a?(klass)
  end
end
