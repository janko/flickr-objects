require "spec_helper"

describe Flickr::List do
  use_vcr_cassette

  before(:each) { @it = Flickr.photos.search(user_id: PERSON_ID) }

  it "has correct attributes" do
    test_attributes(@it, ATTRIBUTES[:list])
  end

  describe "#find" do
    it "finds by ID" do
      @it.find(PHOTO_ID).should be_a(Flickr::Photo)
    end

    it "finds by IDs" do
      @it.find([PHOTO_ID]).first.should be_a(Flickr::Photo)
    end

    it "allows Enumerable#find" do
      @it.find { |photo| photo.id == PHOTO_ID }.should be_a(Flickr::Photo)
    end

    it "has dynamic finders" do
      photo = @it.find(PHOTO_ID)
      @it.find_by_id(photo.id).should eq photo
      @it.find_by_title(photo.title).should eq photo
    end
  end

  describe "#each" do
    it "can loop through its elements" do
      @it.each { |photo| photo.is_a?(Flickr::Photo) }
    end
  end

  describe "#select" do
    it "stays the same type" do
      @it.select { true }.should be_a(@it.class)
    end
  end
end
