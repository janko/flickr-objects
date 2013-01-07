module RSpecHelpers
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  def oauth(client)
    client.builder.handlers.find { |handler| handler == FaradayMiddleware::OAuth }.instance_variable_get("@args").first
  end

  def file(filename)
    File.join(ROOT, "spec/fixtures/files/#{filename}")
  end

  def test_attributes(variable, attributes)
    attributes.each do |attribute, test|
      variable.send(attribute).should instance_eval(&test)
    end
  end

  module ClassMethods
    def test_attributes(attributes)
      it "has correct attributes" do
        test_attributes(@it, attributes)
      end
    end
  end
end
