require "spec_helper"

describe "flickr.photos.getWithoutGeoData" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_without_geo_data(sizes: :all)
    @photo = @response.first
  }

  it_behaves_like "list"
  include_examples "extras"
end
