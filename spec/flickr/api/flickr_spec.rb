require "spec_helper"

describe Flickr do
  describe "flickr.photos.getContactsPhotos" do
    it "should return photos or videos" do
      collection = Flickr.get_media_from_contacts(include_self: 1, extras: EXTRAS)
      collection.find(PHOTO_ID).should be
      collection.find(VIDEO_ID).should be

      Flickr.get_photos_from_contacts(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Photo) }
      Flickr.get_videos_from_contacts(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Video) }
    end
  end

  describe "flickr.test.echo" do
    before(:all) { @response = Flickr.test_echo }
    subject { @response }

    it { should be_a_nonempty(Hash) }
  end

  describe "flickr.test.null" do
    before(:all) { @response = Flickr.test_null }
    subject { @response }
  end
end
