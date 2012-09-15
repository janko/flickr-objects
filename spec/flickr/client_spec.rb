require "spec_helper"

describe Flickr::Client, :vcr do
  describe "exception handling" do
    it "handles oauth errors" do
      Flickr.configure { |config| config.access_token_key = nil }
      expect { Flickr.client.post "flickr.photos.delete", photo_id: 1 }.to raise_error(Flickr::Client::OAuthError)
    end

    it "handles other errors" do
      expect { Flickr.client.get "flickr.nonExistingMethod" }.to raise_error(Flickr::Client::Error)
    end

    it "goes secure when asked for" do
      Flickr.client.url_prefix.scheme.should eq("http")
      Flickr.configure { |config| config.secure = true }
      Flickr.client.url_prefix.scheme.should eq("https")
      Flickr.configure { |config| config.secure = false }
      Flickr.client.url_prefix.scheme.should eq("http")
    end

    it "accepts a proxy" do
      Flickr.configure { |config| config.proxy = "http://proxy.com" }
      Flickr.client.proxy[:uri].to_s.should eq("http://proxy.com")
      Flickr.configure { |config| config.proxy = nil }
      Flickr.client.proxy.should be_nil
    end

    describe Flickr::Client::Error do
      subject do
        begin
          make_request("flickr.nonExistingMethod")
        rescue Flickr::Client::Error => error
          error
        end
      end

      its(:code) { should == 112 }
    end
  end
end
