require "spec_helper"

describe "flickr.photos.getFavorites", :api_method do
  before(:each) {
    @response = Flickr.photos.find(8300578776).get_favorites
    @person = @response.first
  }

  it_behaves_like "list"

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@person, ATTRIBUTES[:person].slice(:id, :nsid, :username, :favorited_at, :icon_server, :icon_farm))
    end
  end
end
