require "spec_helper"

COLLECTION_ATTRIBUTES = {
  current_page:  proc { be_a(Integer) },
  total_pages:   proc { be_a(Integer) },
  per_page:      proc { be_a(Integer) },
  total_entries: proc { be_a(Integer) }
}

describe Flickr::Collection do
  before(:each) { @it = Flickr.media.search(user_id: USER_ID) }
  subject { @it }

  describe "methods" do
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
    COLLECTION_ATTRIBUTES.each do |attribute, test|
      its(attribute) { should instance_eval(&test) }
    end
  end
end
