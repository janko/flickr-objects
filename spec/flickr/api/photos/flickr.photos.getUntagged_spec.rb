require "spec_helper"

describe "flickr.photos.getUntagged", :api_method do
  before(:each) {
    @response = Flickr.photos.get_untagged(sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"
end
