require "spec_helper"

describe "flickr.photos.setContentType" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID)
  }

  it "works" do
    @photo.set_content_type(1)
    @photo.content_type = 1
  end
end
