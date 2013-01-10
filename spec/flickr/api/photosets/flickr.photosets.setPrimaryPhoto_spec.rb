require "spec_helper"

describe "flickr.photosets.setPrimaryPhoto", :api_method do
  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.set_primary_photo(PHOTO_ID)
    @set.primary_photo = PHOTO_ID
  end

  it "accepts a photo" do
    @set.primary_photo = Flickr.photos.find(PHOTO_ID)
  end
end
