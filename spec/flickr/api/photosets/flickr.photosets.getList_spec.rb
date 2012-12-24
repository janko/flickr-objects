require "spec_helper"

describe "flickr.photosets.getList" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_sets
    @set = @response.find(SET_ID)
  }

  it "returns a Flickr::List" do
    @response.should be_a(Flickr::List)
  end

  describe Flickr::Set do
    it "has correct attributes" do
      test_attributes(@set, ATTRIBUTES[:set].except(:owner, :url))
    end
  end
end
