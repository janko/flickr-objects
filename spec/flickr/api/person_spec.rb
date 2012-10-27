require "spec_helper"

describe Flickr::Person do
  before(:each) { @it = Flickr.people.find(USER_ID) }

  describe "flickr.photos.getContactsPublicPhotos" do
    it "returns photos and/or videos" do
      collection = @it.get_public_media_from_contacts(include_self: 1)
      collection.find(PHOTO_ID).should be
      collection.find(VIDEO_ID).should be

      @it.get_public_photos_from_contacts(include_self: 1).each { |object| object.should be_a(Flickr::Photo) }
      @it.get_public_videos_from_contacts(include_self: 1).each { |object| object.should be_a(Flickr::Video) }
    end
  end
end
