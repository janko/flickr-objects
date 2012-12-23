require "spec_helper"

describe "flickr.people.getInfo" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_info!
    @person = @response
  }

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@person, ATTRIBUTES[:person])
    end
  end
end
