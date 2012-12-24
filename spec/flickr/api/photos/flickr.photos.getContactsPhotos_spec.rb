require "spec_helper"

describe "flickr.photos.getContactsPhotos" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_from_contacts(include_self: 1, sizes: :all)
    @photo = @response.first
  }

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
