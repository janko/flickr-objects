require "spec_helper"

describe "flickr.photos.getContactsPublicPhotos", :api_method do
  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_public_photos_from_contacts(include_self: 1, sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"

  describe Flickr::Person do
    it "has username" do
      @photo.owner.username.should be_a_nonempty(String)
    end
  end
end
