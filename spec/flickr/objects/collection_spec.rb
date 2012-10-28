require "spec_helper"

COLLECTION_ATTRIBUTES = {
  current_page:  proc { be_a(Integer) },
  total_pages:   proc { be_a(Integer) },
  per_page:      proc { be_a(Integer) },
  total_entries: proc { be_a(Integer) }
}

describe Flickr::Collection do
  describe "methods" do
    before(:all) { @it = Flickr.media.search(user_id: USER_ID) }
    subject { @it }

    describe "#find" do
      it "finds by ID" do
        @it.find(PHOTO_ID).should be_a(Flickr::Media)
      end

      it "finds by IDs" do
        @it.find([PHOTO_ID]).first.should be_a(Flickr::Media)
      end

      it "allows Enumerable#find" do
        @it.find { |media| media.id == PHOTO_ID }.should be_a(Flickr::Media)
      end
    end

    describe "#each" do
      it "can loop through its elements" do
        @it.each { |media| media.is_a?(Flickr::Media) }
      end
    end

    describe "#select" do
      it "stays the same type" do
        @it.select { true }.should be_a(@it.class)
      end
    end

    it "instantiates the according media types" do
      @it.find(PHOTO_ID).should be_a(Flickr::Photo)
      @it.find(VIDEO_ID).should be_a(Flickr::Video)
    end
  end

  describe "attributes" do
    context "flickr.photos.search" do
      before(:all) { @it = Flickr.photos.search(user_id: USER_ID, extras: EXTRAS) }
      subject { @it }

      test_attributes(COLLECTION_ATTRIBUTES)
    end

    context "flickr.people.getPhotos" do
      before(:all) { @it = Flickr.people.find(USER_ID).get_photos(extras: EXTRAS) }
      subject { @it }

      test_attributes(COLLECTION_ATTRIBUTES)
    end

    context "flickr.people.getPublicPhotos" do
      before(:all) { @it = Flickr.people.find(USER_ID).get_public_photos(extras: EXTRAS) }
      subject { @it }

      test_attributes(COLLECTION_ATTRIBUTES)
    end

    context "flickr.photosets.getList" do
      before(:all) { @it = Flickr.people.find(USER_ID).get_sets }
      subject { @it }

      test_attributes(COLLECTION_ATTRIBUTES)
    end

    context "flickr.photos.getContactsPhotos" do
      before(:all) { @it = Flickr.photos.get_from_contacts(extras: EXTRAS, include_self: 1) }
      subject { @it }

      test_attributes(COLLECTION_ATTRIBUTES)
    end

    context "flickr.photosets.getPhotos" do
      before(:all) { @it = Flickr.sets.find(SET_ID).get_photos }
      subject { @it }

      test_attributes(COLLECTION_ATTRIBUTES)
    end
  end
end
