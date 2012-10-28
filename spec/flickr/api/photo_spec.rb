require "spec_helper"

describe Flickr::Photo do
  describe "flickr.photos.search" do
    before(:all) { @collection = Flickr.photos.search(user_id: USER_ID) }

    it "instantiates photos" do
      @collection.should_not be_empty
      @collection.each { |object| object.should be_a(described_class) }
    end
  end

  describe "flickr.photos.getContactsPhotos" do
    before(:all) { @collection = Flickr.photos.get_from_contacts(extras: EXTRAS, include_self: 1) }

    it "instantiates photos" do
      @collection.should_not be_empty
      @collection.each { |object| object.should be_a(described_class) }
    end
  end
end
