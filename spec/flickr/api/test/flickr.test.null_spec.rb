require "spec_helper"

describe "flickr.test.null" do
  use_vcr_cassette

  before(:each) { @response = Flickr.test_null }

  it "returns a response" do
    @response.should be_a_nonempty(Hash)
  end
end
