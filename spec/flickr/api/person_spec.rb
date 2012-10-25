require "spec_helper"

describe Flickr::Person do
  describe "flickr.photos.getPublicContactsPhotos" do
    before(:all) { @person = Flickr.people.find(USER_ID) }

    it "should return photos or videos" do
      collection = @person.get_public_media_from_contacts(include_self: 1, extras: EXTRAS)
      collection.find(PHOTO_ID).should be
      collection.find(VIDEO_ID).should be

      @person.get_public_photos_from_contacts(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Photo) }
      @person.get_public_videos_from_contacts(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Video) }
    end
  end
end
