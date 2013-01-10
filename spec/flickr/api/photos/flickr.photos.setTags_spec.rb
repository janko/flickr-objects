require "spec_helper"

describe "flickr.photos.setTags", :api_method do
  before(:each) { @photo = Flickr.photos.find(PHOTO_ID) }

  it "works" do
    @photo.set_tags("Test")
    @photo.tags = "Test"
  end
end
