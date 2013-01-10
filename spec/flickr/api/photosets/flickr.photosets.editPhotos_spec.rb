require "spec_helper"

describe "flickr.photosets.editPhotos", :api_method do
  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.edit_photos(primary_photo_id: PHOTO_ID, photo_ids: PHOTO_ID)
  end
end
