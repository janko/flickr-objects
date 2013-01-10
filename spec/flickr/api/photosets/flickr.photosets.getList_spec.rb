require "spec_helper"

describe "flickr.photosets.getList", :api_method do
  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_sets
    @set = @response.find(SET_ID)
  }

  it_behaves_like "list"

  describe Flickr::Set do
    it "has correct attributes" do
      test_attributes(@set, ATTRIBUTES[:set].except(:owner, :url))
    end
  end
end
