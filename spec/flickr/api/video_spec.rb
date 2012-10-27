require "spec_helper"

describe Flickr::Video do
  before(:each) { @it = Flickr.videos.find(VIDEO_ID) }

  describe "flickr.photos.search" do
    before(:all) { @collection = Flickr.videos.search(user_id: USER_ID) }

    it "passes the media type" do
      @collection.should_not be_empty
      @collection.each { |object| object.should be_a(Flickr::Video) }
    end
  end
end
