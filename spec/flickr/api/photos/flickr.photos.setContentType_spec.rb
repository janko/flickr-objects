require "spec_helper"

describe "flickr.photos.setContentType" do
  use_vcr_cassette

  before(:each) {
    @media = Flickr.media.find(MEDIA_ID)
  }

  it "works" do
    @media.set_content_type(1)
    @media.content_type = 1
  end
end
