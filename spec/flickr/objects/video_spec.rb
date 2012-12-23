require "spec_helper"
require "uri"

describe Flickr::Video do
  use_vcr_cassette

  before(:each) { @it = Flickr.media.search(user_id: PERSON_ID, extras: EXTRAS).find(VIDEO_ID) }

  it "has thumbnail methods" do
    @it.thumbnail_url("Square 75").should match URI.regexp
    @it.thumbnail_url("Square 75").should_not eq @it.thumbnail_url("Thumbnail")

    @it.thumbnail_width("Square 75").should eq 75
    @it.thumbnail_height("Square 75").should eq 75
  end

  context "flickr.photos.getSizes" do
    before(:each) { @it = Flickr.videos.find(VIDEO_ID).get_sizes! }

    it "has size methods" do
      @it.thumbnail_url("Square 75").should match URI.regexp
      @it.thumbnail_width("Square 75").should eq 75
      @it.thumbnail_height("Square 75").should eq 75
    end

    it "has a all sizes" do
      Flickr::Video::SIZES.keys.reverse.drop_while { |size| size != @it.largest_size }.each do |size|
        @it.thumbnail_url(size).should be_a_nonempty(String)
      end
    end
  end
end
