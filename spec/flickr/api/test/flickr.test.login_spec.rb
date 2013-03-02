require "spec_helper"

describe "flickr.test.login", :api_method do
  before(:each) { @response = Flickr.test_login }

  it "returns a response" do
    @response.should be_a_nonempty(Hash)
  end
end
