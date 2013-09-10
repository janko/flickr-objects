require "flickr-objects"
require "pry"

Dir["./spec/support/**/*.rb"].each &method(:require)

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }

  config.before do
    Flickr.configure do |config|
      SETTINGS.each do |name, value|
        config.send(:"#{name}=", value) if config.respond_to?(:"#{name}=")
      end
    end
  end

  config.before do
    Flickr.stub(:deprecation_warn)
  end

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.filter_run_excluding slow: true

  config.include Helpers
end
