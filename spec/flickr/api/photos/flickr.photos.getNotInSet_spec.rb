require "spec_helper"

describe "flickr.photos.getNotInSet" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_not_in_set(sizes: :all)
    @photo = @response.first
  }

  it "returns a Flickr::List" do
    @response.should be_a(Flickr::List)
    test_attributes(@response, ATTRIBUTES[:list])
  end

  it "handles extras" do
    @photo.available_sizes.should include("Thumbnail")
  end

  it "returns the expected extras attributes" do
    @photo.instance_variable_get("@hash").keys.reject { |s| s =~ /^(width|url|height)_\w+$/ }.should eq EXTRAS_KEYS
  end
end
