require "spec_helper"

describe "flickr.people.getPhotosOf", :api_method do
  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_photos_of(sizes: :all)
    @photo = @response.find(PHOTO_ID)
  }

  it_behaves_like "list"
  include_examples "extras"
end
