require "spec_helper"

describe "flickr.photosets.getPhotos" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.sets.find(SET_ID).get_photos(extras: EXTRAS)
    @photo = @response.find(PHOTO_ID)
  end

  it "returns a Flickr::Collection" do
    @response.should be_a(Flickr::Collection)
  end

  it "assigns attributes correctly" do
    @photo.id.should be_a_nonempty(String)
  end
end
