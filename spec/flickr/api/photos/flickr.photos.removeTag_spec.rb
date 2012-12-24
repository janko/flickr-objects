require "spec_helper"

describe "flickr.photos.removeTag" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID).get_info!
  }

  it "works" do
    @photo.remove_tag(@photo.tags.first.id)
    @photo.set_tags("Test")
  end
end
