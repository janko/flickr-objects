require "spec_helper"

describe "flickr.photos.search" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.photos.search(user_id: PERSON_ID, sizes: :all)
    @photo = @response.find(PHOTO_ID)
  end

  it_behaves_like "list"
  include_examples "extras"
end
