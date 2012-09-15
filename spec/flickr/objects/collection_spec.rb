require "spec_helper"

COLLECTION_ATTRIBUTES = {
  current_page:  proc { be_a(Integer) },
  total_pages:   proc { be_a(Integer) },
  per_page:      proc { be_a(Integer) },
  total_entries: proc { be_a(Integer) }
}

describe Flickr::Collection, :vcr do
  before(:all) { @collection = make_request("flickr.photos.search") }
  subject { @collection }

  describe "methods" do
    describe "#find" do
      it "finds by ID" do
        @collection.find(PHOTO_ID).should be_a(Flickr::Media)
      end

      it "finds by IDs" do
        @collection.find([PHOTO_ID]).first.should be_a(Flickr::Media)
      end

      it "allows Array#find" do
        @collection.find { |media| media.id == PHOTO_ID }.should be_a(Flickr::Media)
      end
    end

    describe "#each" do
      it "can loop through its elements" do
        @collection.each { |media| media.is_a?(Flickr::Media) }
      end
    end
  end

  describe "attributes" do
    COLLECTION_ATTRIBUTES.each do |attribute, test|
      its(attribute) { should instance_eval(&test) }
    end
  end
end
