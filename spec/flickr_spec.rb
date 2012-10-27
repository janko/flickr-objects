require "spec_helper"

describe Flickr do
  before(:each) { @it = Flickr }

  it "has a list of registered API methods" do
    @it.api_methods["flickr.photos.search"].should eq ["Flickr::Media.search", "Flickr::Photo.search", "Flickr::Video.search"]
    @it.api_methods["flickr.photos.getInfo"].should eq ["Flickr::Media#get_info!", "Flickr::Photo#get_info!", "Flickr::Video#get_info!"]
  end

  it "has an interface" do
    @it.media.should eq Flickr::Media
  end

  describe "instance" do
    before(:each) { @it = Flickr.new(ENV["FLICKR_ACCESS_TOKEN"], ENV["FLICKR_ACCESS_SECRET"]) }

    it "has clients" do
      @it.client.should be_a(Flickr::MethodsClient)
      @it.upload_client.should be_a(Flickr::UploadClient)
    end

    it "can has a different access token" do
      expect { @it.client.get "flickr.test.login" }.to_not raise_error(Flickr::Client::OAuthError)
      @it = Flickr.new(nil, nil)
      expect { @it.client.get "flickr.test.login", vcr: "without access token" }.to raise_error(Flickr::Client::OAuthError)
    end

    it "has the interface" do
      @it.media.should eq Flickr::Media
    end
  end
end
