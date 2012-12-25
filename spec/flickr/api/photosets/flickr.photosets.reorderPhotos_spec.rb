require "spec_helper"

describe "flickr.photosets.reorderPhotos" do
  use_vcr_cassette

  before(:each) {
    @set = Flickr.sets.find(SET_ID)
  }

  it "works" do
    @set.reorder_photos(PHOTO_ID)
  end
end
