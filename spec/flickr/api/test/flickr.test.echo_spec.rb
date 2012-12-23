require "spec_helper"

describe "flickr.test.echo" do
  use_vcr_cassette

  before(:each) { @response = Flickr.test_echo }

  it "returns a response" do
    @response.should be_a_nonempty(Hash)
  end
end
