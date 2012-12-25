require "spec_helper"

describe "flickr.photos.transform.rotate" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID)
  }

  it "works" do
    @photo.rotate(180)
  end
end
