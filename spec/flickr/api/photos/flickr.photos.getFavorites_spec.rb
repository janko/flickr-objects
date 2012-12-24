require "spec_helper"

describe "flickr.photos.getFavorites" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.find(8300578776).get_favorites
    @person = @response.first
  }

  it "returns a Flickr::List" do
    @response.should be_a(Flickr::List)
    test_attributes(@response, ATTRIBUTES[:list])
  end

  it "assigns attributes correctly" do
    test_attributes(@person, ATTRIBUTES[:person].slice(:id, :nsid, :username, :favorited_at, :icon_server, :icon_farm))
  end
end
