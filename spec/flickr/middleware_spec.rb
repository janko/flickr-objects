require "spec_helper"

describe Flickr::Middleware, :vcr do
  describe Flickr::Middleware::CheckStatus do
    before(:each) do
      Flickr.configure { |config| config.api_key = nil }
      @error = begin
                 Flickr.test_login
               rescue Flickr::ApiError => error
                 error
               end
    end

    it "gives the proper error code and message" do
      @error.code.should eq 100
      @error.message.should eq "Invalid API Key (Key has invalid format)"
    end
  end

  describe Flickr::Middleware::CheckOAuth do
    before(:each) do
      Flickr.configure { |config| config.access_token_secret = nil }
      @error = begin
                 Flickr.test_login
               rescue Flickr::OAuthError => error
                 error
               end
    end

    it "gives the error a pretty message" do
      @error.message.should eq "Signature invalid"
    end
  end

  describe Flickr::Middleware::Retry do
    before(:each) do
      Flickr.configure { |config| config.open_timeout = 0.1 }
      @error = begin
                 Flickr.test_login
               rescue => error
                 error
               end
    end

    after(:each) do
      Flickr.configure { |config| config.open_timeout = nil }
    end

    it "raises a Flickr::TimeoutError with a message" do
      @error.should be_a(Flickr::TimeoutError)
      @error.message.should eq "execution expired"
    end
  end
end
