require "spec_helper"

describe Flickr::Tag do
  let(:media) { Flickr::Media.find(PHOTO_ID) }

  describe "flickr.photos.removeTag" do
    it "works" do
      media.add_tags "Cool", vcr: "tag 1"
      media.get_info!(vcr: "tag 2")
      media.tags.last.delete(vcr: "tag 3")
      media.get_info!(vcr: "tag 4")
      media.tags.count.should eq(1)
    end

    it "has the alias" do
      media.get_info!
      media.tags.last.should respond_to(:remove)
    end
  end
end
