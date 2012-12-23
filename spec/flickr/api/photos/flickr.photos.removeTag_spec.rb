require "spec_helper"

describe "flickr.photos.removeTag" do
  use_vcr_cassette

  before(:each) {
    @media = Flickr.media.find(MEDIA_ID).get_info!
  }

  it "works" do
    @media.remove_tag(@media.tags.first.id)
    @media.set_tags("Test")
  end
end
