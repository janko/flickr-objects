require "spec_helper"

describe "flickr.people.getPhotos" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_photos(sizes: :all)
    @photo = @response.find(PHOTO_ID)
  }

  it_behaves_like "list"
  include_examples "extras"
end
