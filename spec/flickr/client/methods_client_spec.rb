require "spec_helper"

describe Flickr::MethodsClient, :vcr do
  before(:each) { @it = Flickr.client }

  it "parses the JSON response" do
    @it.get("flickr.test.login").should be_a(Hash)
  end
end
