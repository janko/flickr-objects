require "spec_helper"

describe "flickr.photos.getExif" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.find(PHOTO_ID).get_exif
  }

  describe Flickr::Photo::Exif do
    before(:each) { @it = @response }

    it "has correct attributes" do
      @it.camera.should be_a(String)
    end

    describe described_class::Item do
      before(:each) { @it = @it.items.find { |item| item.clean != nil } }

      it "has correct attributes" do
        [:tagspace, :tagspace_id, :tag, :label, :raw, :clean].each do |attribute|
          @it.send(attribute).should be_a_nonempty(String)
        end
      end
    end

    describe "#[]" do
      it "searches by label" do
        item = @it.items.first
        @it[item.label].should be_a_nonempty(String)
      end

      it "prefers clean over raw" do
        item = @it.items.find { |item| item.clean != nil }
        @it[item.label].should eq item.clean
        item = @it.items.find { |item| item.clean == nil }
        @it[item.label].should eq item.raw
      end
    end
  end
end
