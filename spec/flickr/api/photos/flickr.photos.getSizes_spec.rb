require "spec_helper"

describe "flickr.photos.getSizes" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.find(PHOTO_ID).get_sizes!
    @photo = @response
  }

  it "sets attributes" do
    @photo.thumbnail.source_url.should be_a_nonempty(String)
  end
end
