require "spec_helper"

describe Flickr::Video do
  describe "flickr.photos.search" do
    before(:all) { @videos = Flickr.videos.search(user_id: USER_ID) }

    it "passes the media type" do
      @videos.should_not be_empty
      @videos.each { |video| video.should be_a(Flickr::Video) }
    end
  end
end
