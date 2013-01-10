require "spec_helper"

describe "flickr.photos.setSafetyLevel", :api_method do
  before(:each) { @photo = Flickr.photos.find(PHOTO_ID) }

  it "works" do
    @photo.set_safety_level(safety_level: 1)
  end
end
