require "spec_helper"

describe "flickr.photosets.removePhoto", :api_method do
  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.add_photo(OTHER_PHOTO_ID)
    @set.remove_photo(OTHER_PHOTO_ID)
  end
end
