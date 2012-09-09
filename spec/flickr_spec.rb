require "spec_helper"

describe Flickr, :vcr do
  describe ".api_methods" do
    it "works" do
      Flickr.api_methods["flickr.photos.search"].should eq(["Flickr::Media.search", "Flickr::Photo.search", "Flickr::Video.search"])
      Flickr.api_methods["flickr.photos.getInfo"].should eq(["Flickr::Media#get_info!", "Flickr::Photo#get_info!", "Flickr::Video#get_info!"])
    end
  end

  describe "interface" do
    it "maps to object classes" do
      Flickr.media.methods.should == Flickr::Media.methods
    end
  end

  describe "instance" do
    it "has a different client" do
      expect { Flickr.test_login }.to_not raise_error(Flickr::Client::Error)
      flickr = Flickr.new(nil, nil)
      expect { flickr.test_login }.to raise_error(Flickr::Client::OAuthError)
    end

    it "is able to make requests" do
      flickr = Flickr.new(ENV["FLICKR_ACCESS_TOKEN"], ENV["FLICKR_ACCESS_SECRET"])
      expect { flickr.test_login }.to_not raise_error(Flickr::Client::Error)
    end

    it "has the interface" do
      Flickr.new.media.methods.should == Flickr::Media.methods
    end
  end
end
