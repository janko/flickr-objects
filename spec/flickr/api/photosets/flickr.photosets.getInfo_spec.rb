require "spec_helper"

describe "flickr.photosets.getInfo" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.sets.find(SET_ID).get_info!
    @set = @response
  }

  describe Flickr::Set do
    it "has correct attributes" do
      test_attributes(@set, ATTRIBUTES[:set])
    end
  end

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@set.owner, ATTRIBUTES[:person].slice(:id, :nsid, :username))
    end
  end

  describe Flickr::Media do
    it "has correct attributes" do
      test_attributes(@set.primary_media, ATTRIBUTES[:media].slice(:id))
      test_attributes(@set.primary_photo, ATTRIBUTES[:media].slice(:id))
      test_attributes(@set.primary_video, ATTRIBUTES[:media].slice(:id))
    end
  end
end
