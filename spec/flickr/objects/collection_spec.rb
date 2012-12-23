require "spec_helper"

describe Flickr::Collection do
  use_vcr_cassette

  before(:each) { @it = Flickr.media.search(user_id: PERSON_ID) }

  it "has correct attributes" do
    test_attributes(@it, ATTRIBUTES[:collection])
  end

  describe "#find" do
    it "finds by ID" do
      @it.find(PHOTO_ID).should be_a(Flickr::Media)
    end

    it "finds by IDs" do
      @it.find([PHOTO_ID]).first.should be_a(Flickr::Media)
    end

    it "allows Enumerable#find" do
      @it.find { |media| media.id == PHOTO_ID }.should be_a(Flickr::Media)
    end

    it "has dynamic finders" do
      photo = @it.find(PHOTO_ID)
      @it.find_by_id(photo.id).should eq photo
      @it.find_by_title(photo.title).should eq photo
    end
  end

  describe "#each" do
    it "can loop through its elements" do
      @it.each { |media| media.is_a?(Flickr::Media) }
    end
  end

  describe "#select" do
    it "stays the same type" do
      @it.select { true }.should be_a(@it.class)
    end
  end

  it "instantiates the according media types" do
    @it.find(PHOTO_ID).should be_a(Flickr::Photo)
    @it.find(VIDEO_ID).should be_a(Flickr::Video)
  end
end
