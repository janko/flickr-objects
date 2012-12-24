require "spec_helper"

describe "flickr.people.getPhotos" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.people.find(PERSON_ID).get_photos(sizes: :all)
    @photo = @response.find(PHOTO_ID)
  end

  it "returns a Flickr::List" do
    @response.should be_a(Flickr::List)
    test_attributes(@response, ATTRIBUTES[:list])
  end

  it "handles extras" do
    @photo.available_sizes.should include("Thumbnail")
  end

  it "assigns attributes correctly" do
    @photo.id.should be_a_nonempty(String)
  end
end
