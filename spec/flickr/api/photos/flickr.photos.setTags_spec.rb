require "spec_helper"

describe "flickr.photos.setTags" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID)
  }

  it "works" do
    @photo.set_tags("Test")
    @photo.tags = "Test"
  end
end
