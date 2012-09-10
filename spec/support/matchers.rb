RSpec::Matchers.define :be_a_nonempty do |klass|
  match do |actual|
    actual.is_a?(klass) and not actual.empty?
  end
end

RSpec::Matchers.define :be_an_empty do |klass|
  match do |actual|
    actual.is_a?(klass) and actual.empty?
  end
end

RSpec::Matchers.define :be_a_boolean do
  match do |actual|
    actual == true or actual == false
  end
end
