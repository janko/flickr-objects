require "spec_helper"

describe "flickr.people.getPublicPhotos" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.people.find(PERSON_ID).get_public_photos(sizes: :all)
    @photo = @response.find(PHOTO_ID)
  end

  it_behaves_like "list"
  include_examples "extras"
end
