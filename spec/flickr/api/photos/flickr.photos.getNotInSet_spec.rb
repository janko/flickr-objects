require "spec_helper"

describe "flickr.photos.getNotInSet" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_not_in_set(sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"
end
