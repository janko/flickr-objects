require "spec_helper"

describe Flickr::Video do
  describe "flickr.photos.search" do
    before(:all) { @collection = Flickr.videos.search(user_id: USER_ID) }

    it "instantiates videos" do
      @collection.should_not be_empty
      @collection.each { |object| object.should be_a(described_class) }
    end
  end

  describe "flickr.photos.getContactsPhotos" do
    before(:all) { @collection = Flickr.videos.get_from_contacts(extras: EXTRAS, include_self: 1) }

    it "instantiates videos" do
      @collection.should_not be_empty
      @collection.each { |object| object.should be_a(described_class) }
    end
  end
end
