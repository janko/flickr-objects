module RSpecHelpers
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def test_attributes(attributes)
      attributes.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
