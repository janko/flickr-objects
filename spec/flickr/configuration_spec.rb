require "spec_helper"

describe Flickr::Configuration do
  describe "Flickr.configure" do
    it "works" do
      Flickr.configuration.open_timeout.should be_nil
      Flickr.configure { |config| config.open_timeout = 3 }
      Flickr.configuration.open_timeout.should == 3
    end

    it "resets the client", :vcr do
      Flickr.configure { |config| config.api_key = nil }
      expect { Flickr.client.get "flickr.test.login" }.to raise_error
      Flickr.configure { |config| config.api_key = ENV["FLICKR_API_KEY"] }
      expect { Flickr.client.get "flickr.test.login" }.to_not raise_error
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
