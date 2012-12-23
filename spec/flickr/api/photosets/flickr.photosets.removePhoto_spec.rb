require "spec_helper"

describe "flickr.photosets.removePhoto" do
  use_vcr_cassette

  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.add_photo(VIDEO_ID)
    @set.remove_photo(VIDEO_ID)

    @set.add_video(VIDEO_ID)
    @set.remove_video(VIDEO_ID)

    @set.add_media(VIDEO_ID)
    @set.remove_media(VIDEO_ID)
  end
end
