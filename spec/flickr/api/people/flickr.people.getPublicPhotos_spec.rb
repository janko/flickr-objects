require "spec_helper"

describe "flickr.people.getPublicPhotos" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.people.find(PERSON_ID).get_public_photos(extras: EXTRAS)
    @photo = @response.find(PHOTO_ID)
  end

  it "returns a Flickr::List" do
    @response.should be_a(Flickr::List)
  end

  it "assigns attributes correctly" do
    @photo.id.should be_a_nonempty(String)
  end
end
