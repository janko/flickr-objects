require "spec_helper"

describe Flickr::Media do
  before(:each) { @it = Flickr.media.find(PHOTO_ID) }

  describe "flickr.photos.setContentType" do
    it "works" do
      @it.set_content_type(1)
    end

    it "has the cool alias" do
      @it.should respond_to(:content_type=)
    end
  end

  describe "flickr.photos.addTags" do
    it "works" do
      @it.add_tags "Cool"
      tag_id = @it.get_info!.tags.last.id
      @it.remove_tag(tag_id)
    end
  end

  describe "flickr.photos.setTags" do
    it "works" do
      old_tags = @it.get_info!.tags.join(",")
      @it.set_tags "Cool"
      @it.set_tags old_tags
    end

    it "has the cool alias" do
      @it.should respond_to(:tags=)
    end
  end
end
