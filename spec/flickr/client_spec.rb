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

    describe Flickr::Client::Error do
      it "has the #code attribute" do
        begin
          Flickr.client.get "flickr.nonExistingMethod"
        rescue Flickr::Client::Error => error
        end

        error.code.should == 112
      end
    end
  end
end
