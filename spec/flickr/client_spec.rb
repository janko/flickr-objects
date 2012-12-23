require "spec_helper"
require "uri"

describe Flickr::Client, :vcr do
  it "can go over a secure network" do
    expect {
      Flickr.configure do |config|
        config.secure = true
      end
    }.to change{Flickr.client.url_prefix.scheme}.from("http").to("https")
    Flickr.test_login["stat"].should eq "ok"

    Flickr.configure { |config| config.secure = false }
  end

  it "can go over a proxy" do
    expect {
      Flickr.configure do |config|
        config.proxy = "http://proxy.com"
      end
    }.to change{Flickr.client.proxy}.from(nil).to(uri: URI.parse("http://proxy.com"))

    Flickr.configure { |config| config.proxy = nil }
  end

  context "errors" do
    it "raises OAuth errors" do
      Flickr.configure { |config| config.access_token_key = nil }
      expect { Flickr.test_login }.to raise_error(Flickr::OAuthError)
    end

    it "raises API errors" do
      Flickr.configure { |config| config.api_key = nil }
      expect { Flickr.test_login }.to raise_error(Flickr::ApiError)
    end

    it "raises timeout errors" do
      Flickr.configure { |config| config.open_timeout = 0.1 }
      expect { Flickr.test_login }.to raise_error(Flickr::TimeoutError)

      Flickr.configure { |config| config.open_timeout = nil }
    end
  end
end
