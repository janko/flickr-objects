require "spec_helper"

describe "flickr.photos.getUntagged" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_untagged(sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"
end
