require "spec_helper"

describe Flickr::Photo do
  describe "flickr.photos.search" do
    before(:all) { @photos = Flickr.photos.search(user_id: USER_ID) }

    it "passes the media type" do
      @photos.should_not be_empty
      @photos.each { |photo| photo.should be_a(Flickr::Photo) }
    end
  end
end
