require "spec_helper"

describe "flickr.photos.search", :api_method do
  before(:each) {
    @response = Flickr.photos.search(user_id: PERSON_ID, sizes: :all)
    @photo = @response.find(PHOTO_ID)
  }

  it_behaves_like "list"
  include_examples "extras"
end
