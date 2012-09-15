require "spec_helper"

describe Flickr::Photo, :vcr do
  describe "flickr.photos.search" do
    before(:all) { @photos = make_request("flickr.photos.search", Flickr::Photo) }

    it "passes the media type" do
      @photos.should_not be_empty
      @photos.each { |photo| photo.should be_a(Flickr::Photo) }
    end
  end
end
