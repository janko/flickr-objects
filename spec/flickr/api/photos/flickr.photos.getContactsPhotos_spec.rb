require "spec_helper"

describe "flickr.photos.getContactsPhotos" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_from_contacts(include_self: 1, sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"

  it "has owner's username" do
    @photo.owner.username.should_not be_empty
  end
end
