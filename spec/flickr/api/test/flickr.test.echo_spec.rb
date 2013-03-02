require "spec_helper"

describe "flickr.test.echo", :api_method do
  before(:each) { @response = Flickr.test_echo }

  it "returns a response" do
    @response.should be_a_nonempty(Hash)
  end
end
