require "spec_helper"

describe Flickr::Photo do
  before(:each) { @it = Flickr.photos.find(PHOTO_ID) }

  describe "flickr.photos.search" do
    before(:each) { @collection = Flickr.photos.search(user_id: USER_ID) }

    it "passes the media type" do
      @collection.should_not be_empty
      @collection.each { |object| object.should be_a(Flickr::Photo) }
    end
  end
end
