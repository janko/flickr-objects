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
      expect { Flickr.test_login(vcr: "without api key") }.to raise_error
    end
  end
end
