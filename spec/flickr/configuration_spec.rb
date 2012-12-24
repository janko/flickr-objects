require "spec_helper"

describe Flickr::Configuration do
  describe "Flickr.configure" do
    it "works" do
      expect {
        Flickr.configure do
          |config| config.open_timeout = 4
        end
      }.to change{Flickr.configuration.open_timeout}.from(nil).to(4)
    end

    it "resets the clients" do
      oauth(Flickr.client)[:consumer_key].should_not be_nil
      oauth(Flickr.upload_client)[:consumer_key].should_not be_nil
      Flickr.configure { |config| config.api_key = nil }
      oauth(Flickr.client)[:consumer_key].should be_nil
      oauth(Flickr.upload_client)[:consumer_key].should be_nil
    end
  end

  it "responds to certain attributes" do
    attributes = [
      :api_key, :shared_secret,
      :access_token_key, :access_token_secret,
      :open_timeout, :timeout,
      :secure, :proxy,
      :pagination
    ]
    attributes.each do |attribute|
      Flickr.configuration.should respond_to(attribute)
    end
  end
end
