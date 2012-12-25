require "spec_helper"

describe "flickr.photos.setMeta" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID)
  }

  it "works" do
    @photo.set_meta(title: "Title", description: "Description")
  end
end
