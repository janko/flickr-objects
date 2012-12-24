require "spec_helper"

describe "flickr.photos.getContactsPublicPhotos" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_public_photos_from_contacts(include_self: 1, sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"

  it "has owner's username" do
    @photo.owner.username.should_not be_empty
  end
end
