RSpec::Matchers.define :be_a_nonempty do |klass|
  match do |actual|
    actual.is_a?(klass) and not actual.empty?
  end
end
