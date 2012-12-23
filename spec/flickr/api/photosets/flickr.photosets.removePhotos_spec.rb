require "spec_helper"

describe "flickr.photosets.removePhotos" do
  use_vcr_cassette

  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.add_photo(VIDEO_ID)
    @set.remove_photos(VIDEO_ID)

    @set.add_video(VIDEO_ID)
    @set.remove_videos(VIDEO_ID)

    @set.add_media(VIDEO_ID)
    @set.remove_media(VIDEO_ID)
  end
end
