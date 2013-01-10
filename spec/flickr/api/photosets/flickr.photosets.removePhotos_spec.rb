require "spec_helper"

describe "flickr.photosets.removePhotos", :api_method do
  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.add_photo(OTHER_PHOTO_ID)
    @set.remove_photos(OTHER_PHOTO_ID)
  end
end
