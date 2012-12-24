require "spec_helper"

describe "flickr.photos.getContactsPhotos" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_from_contacts(include_self: 1)
    @photo = @response.first
  }

  it "returns a Flickr::Collection" do
    @response.should be_a(Flickr::Collection)
  end

  it "assigns attributes correctly" do
    @photo.id.should be_a_nonempty(String)
  end
end
