require "spec_helper"

describe "flickr.photosets.getPhotos" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.sets.find(SET_ID).get_photos(extras: EXTRAS)
    @media = @response.find(MEDIA_ID)
  end

  it "returns a right kind of collections" do
    @response.should be_a(Flickr::Collection)

    set = Flickr.sets.find(SET_ID)
    set.get_media(extras: EXTRAS).should have(1).items
    set.get_photos(extras: EXTRAS).should have(1).items
    set.get_videos(extras: EXTRAS).should have(0).items
  end

  it "assigns attributes correctly" do
    @media.id.should be_a_nonempty(String)
  end
end
