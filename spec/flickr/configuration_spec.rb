require "spec_helper"

describe Flickr::Configuration do
  describe "Flickr.configure" do
    it "works" do
      Flickr.configuration.open_timeout.should be_nil
      Flickr.configure { |config| config.open_timeout = 3 }
      Flickr.configuration.open_timeout.should == 3
    end

    it "resets the client" do
      Flickr.configure { |config| config.api_key = nil }
      expect { Flickr.test_login(vcr: "configuration 1") }.to raise_error
      Flickr.configure { |config| config.api_key = ENV["FLICKR_API_KEY"] }
      expect { Flickr.test_login(vcr: "configuration 2") }.to_not raise_error
    end
  end

  it "has correctly spelled attributes" do
    attributes = [
      :api_key, :shared_secret,
      :access_token_key, :access_token_secret,
      :open_timeout, :timeout
    ]

    attributes.each do |attribute|
      Flickr.configuration.should respond_to(attribute)
    end
  end
end
