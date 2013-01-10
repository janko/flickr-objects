require "spec_helper"

describe "flickr.photos.getNotInSet", :api_method do
  before(:each) {
    @response = Flickr.photos.get_not_in_set(sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"
end
