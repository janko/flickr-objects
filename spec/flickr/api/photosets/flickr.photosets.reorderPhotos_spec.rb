require "spec_helper"

describe "flickr.photosets.reorderPhotos", :api_method do
  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.reorder_photos(PHOTO_ID)
  end
end
