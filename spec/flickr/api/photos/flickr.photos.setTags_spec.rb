require "spec_helper"

describe "flickr.photos.setTags" do
  use_vcr_cassette

  before(:each) {
    @media = Flickr.media.find(MEDIA_ID)
  }

  it "works" do
    @media.set_tags("Test")
    @media.tags = "Test"
  end
end
