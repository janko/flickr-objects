require "spec_helper"

describe "flickr.people.search" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.photos.search(user_id: PERSON_ID, extras: EXTRAS)
    @photo = @response.find(PHOTO_ID)
  end

  it "returns a Flickr::Collection" do
    @response.should be_a(Flickr::Collection)
  end

  it "assigns attributes correctly" do
    @photo.id.should be_a_nonempty(String)
  end
end
