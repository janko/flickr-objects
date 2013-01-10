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

  def test_attributes(object, attributes)
    attributes.each do |attribute, test|
      object.send(attribute).should instance_eval(&test)
    end
  end

  module ClassMethods
  end
end

def benchmark(name = "benchmark", &block)
  time = Time.now
  return_value = block.call
  puts "#{name} (#{Time.now - time})"
  return_value
end
