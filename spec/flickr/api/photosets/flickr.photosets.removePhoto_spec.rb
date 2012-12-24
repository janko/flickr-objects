require "spec_helper"

describe "flickr.photosets.removePhoto" do
  use_vcr_cassette

  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.add_photo(OTHER_PHOTO_ID)
    @set.remove_photo(OTHER_PHOTO_ID)
  end
end
