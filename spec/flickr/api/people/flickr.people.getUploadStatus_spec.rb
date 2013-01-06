require "spec_helper"

describe "flickr.people.getUploadStatus" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.people.get_upload_status
    @upload_status = @response
  }

  describe Flickr::Person::UploadStatus do
    before(:each) { @it = @upload_status }

    it "has correct attributes" do
      @it.current_month.maximum.should be_a(Integer)
      @it.current_month.used.should be_a(Integer)
      @it.current_month.remaining.should be_a(Integer)
      @it.maximum_photo_size.should be_a(Integer)
    end
  end
end
