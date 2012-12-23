require "spec_helper"

describe "flickr.photosets.editPhotos" do
  use_vcr_cassette

  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.edit_photos(primary_photo_id: MEDIA_ID, photo_ids: MEDIA_ID)
    @set.edit_videos(primary_photo_id: MEDIA_ID, photo_ids: MEDIA_ID)
    @set.edit_media(primary_photo_id: MEDIA_ID, photo_ids: MEDIA_ID)
  end
end
