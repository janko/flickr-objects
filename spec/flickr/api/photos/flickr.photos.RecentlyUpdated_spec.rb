require "spec_helper"

describe "flickr.photos.RecentlyUpdated", :api_method do
  before(:each) {
    @response = Flickr.photos.get_recently_updated(sizes: :all, min_date: 123456789)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"
end
