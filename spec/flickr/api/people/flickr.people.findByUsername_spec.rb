require "spec_helper"

describe "flickr.people.findByUsername" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.people.find_by_username(PERSON_USERNAME)
    @person = @response
  }

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@person, ATTRIBUTES[:person].slice(:id, :nsid, :username))
    end
  end
end
