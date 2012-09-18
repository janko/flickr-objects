require "spec_helper"

describe Flickr::Media do
  let(:media) { Flickr::Media.find(PHOTO_ID) }

  describe "flickr.photos.setContentType" do
    it "works" do
      media.set_content_type(1)
    end

    it "has the cool alias" do
      media.should respond_to(:content_type=)
    end
  end

  describe "flickr.photos.addTags" do
    it "works" do
      media.add_tags "Cool"
      media.get_info!
      media.remove_tag(media.tags.last)
    end
  end

  describe "flickr.photos.setTags" do
    it "works" do
      media.set_tags "Cool"
      media.set_tags "Test"
    end

    it "has the cool alias" do
      media.should respond_to(:tags=)
    end
  end
end
