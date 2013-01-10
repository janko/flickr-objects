require "spec_helper"

describe "flickr.photos.getExif", :api_method do
  before(:each) { @photo = Flickr.photos.find(PHOTO_ID).get_exif! }

  describe Flickr::Photo do
    it "has camera" do
      @photo.camera.should be_a(String)
    end

    describe Flickr::Photo::Exif do
      before(:each) { @it = @photo.exif }

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

      describe Flickr::Photo::Exif::Item do
        before(:each) { @it = @photo.exif.items.find { |item| item.clean != nil } }

        it "has correct attributes" do
          test_attributes(@it, ATTRIBUTES[:exif_item])
        end
      end
    end
  end
end

ATTRIBUTES[:exif_item] = {
  tagspace:    proc { be_a_nonempty(String) },
  tagspace_id: proc { be_a_nonempty(String) },
  tag:         proc { be_a_nonempty(String) },
  label:       proc { be_a_nonempty(String) },
  raw:         proc { be_a_nonempty(String) },
  clean:       proc { be_a_nonempty(String) },
}
