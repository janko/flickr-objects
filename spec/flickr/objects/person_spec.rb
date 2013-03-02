require "spec_helper"

describe Flickr::Person, :vcr do
  before(:each) { @it = Flickr.people.find(PERSON_ID).get_info! }

  describe "#buddy_icon_url" do
    it "is valid" do
      @it.buddy_icon_url.should be_an_existing_url
      @it.stub(:icon_server).and_return(0)
      @it.buddy_icon_url.should be_an_existing_url
    end
  end
end
