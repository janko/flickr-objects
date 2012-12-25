require "spec_helper"

describe "flickr.photos.setSafetyLevel" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID)
  }

  it "works" do
    @photo.set_safety_level(safety_level: 1)
  end
end
