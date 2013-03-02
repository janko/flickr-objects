require "spec_helper"

describe "flickr.test.null", :api_method do
  before(:each) { @response = Flickr.test_null }

  it "returns a response" do
    @response.should be_a_nonempty(Hash)
  end
end
