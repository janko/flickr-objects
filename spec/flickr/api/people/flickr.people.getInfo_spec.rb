require "spec_helper"

describe "flickr.people.getInfo", :api_method do
  before(:each) { @person = Flickr.people.find(PERSON_ID).get_info!  }

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@person, ATTRIBUTES[:person].slice(:id, :nsid, :username))
    end
  end
end
