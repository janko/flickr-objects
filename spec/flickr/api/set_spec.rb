require "spec_helper"

describe Flickr::Set do
  before(:each) { @it = Flickr.sets.find(SET_ID) }

  describe "flickr.photosets.addPhoto and flickr.photosets.removePhoto" do
    it "works" do
      @it.add_media(MEDIA_ID)
      @it.remove_media(MEDIA_ID)

      @it.add_photo(PHOTO_ID)
      @it.remove_photo(PHOTO_ID)

      @it.add_video(VIDEO_ID)
      @it.remove_video(VIDEO_ID)
    end
  end

  describe "flickr.photosets.removePhotos" do
    it "works" do
      @it.add_media(MEDIA_ID)
      @it.remove_media(MEDIA_ID)

      @it.add_photo(PHOTO_ID)
      @it.remove_photos(PHOTO_ID)

      @it.add_video(VIDEO_ID)
      @it.remove_videos(VIDEO_ID)
    end
  end

  describe "flickr.photosets.getPhotos" do
    it "returns photos and/or videos" do
      @it.get_media.each { |object| (object.is_a?(Flickr::Photo) or object.is_a?(Flickr::Video)).should be_true }
      @it.get_photos.each { |object| object.should be_a(Flickr::Photo) }
      @it.get_videos.each { |object| object.should be_a(Flickr::Video) }
    end
  end
end
