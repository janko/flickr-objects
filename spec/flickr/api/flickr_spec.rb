require "spec_helper"

describe Flickr do
  before(:each) { @it = Flickr }

  describe "#upload" do
    it "returns a valid media ID" do
      pending "After ticket implementation"
    end

    context "when async" do
    end
  end

  # After pro account
  describe "#replace" do
    it "returns a valid media ID" do
    end

    context "when async" do
    end
  end

  describe "flickr.photos.getContactsPhotos" do
    it "returns photos and/or videos" do
      collection = @it.get_media_from_contacts(include_self: 1, extras: EXTRAS)
      collection.find(PHOTO_ID).should be
      collection.find(VIDEO_ID).should be

      @it.get_photos_from_contacts(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Photo) }
      @it.get_videos_from_contacts(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Video) }
    end
  end

  describe "flickr.test.login" do
    before(:each) { @response = @it.test_login }
    subject { @response }

    it { should be_a_nonempty(Hash) }
  end

  describe "flickr.test.echo" do
    before(:each) { @response = @it.test_echo }
    subject { @response }

    it { should be_a_nonempty(Hash) }
  end

  describe "flickr.test.null" do
    before(:each) { @response = @it.test_null }
    subject { @response }

    it { should be_a_nonempty(Hash) }
  end
end
