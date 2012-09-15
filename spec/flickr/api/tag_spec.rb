require "spec_helper"

describe Flickr::Tag, :vcr do
  let(:media) { Flickr::Media.find(PHOTO_ID) }

  describe "flickr.photos.removeTag" do
    it "works" do
      media.add_tags "Cool"
      media.get_info!
      media.tags.count.should eq(2)

      media.tags.last.delete
      media.get_info!
      media.tags.count.should eq(1)
    end

    it "has the alias" do
      media.get_info!
      media.tags.last.should respond_to(:remove)
    end
  end
end
