require "spec_helper"

describe "flickr.people.findByEmail", :api_method do
  before(:each) { @person = Flickr.people.find_by_email(PERSON_EMAIL) }

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@person, ATTRIBUTES[:person].slice(:id, :nsid, :username))
    end
  end
end
