require "spec_helper"

describe "flickr.photosets.getPhotos", :api_method do
  before(:each) do
    @response = Flickr.sets.find(SET_ID).get_photos(sizes: :all)
    @photo = @response.find(PHOTO_ID)
  end

  it_behaves_like "list"
  include_examples "extras"
end
