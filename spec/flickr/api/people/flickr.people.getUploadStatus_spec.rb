require "spec_helper"

describe "flickr.people.getUploadStatus", :api_method do
  before(:each) { @upload_status = Flickr.people.get_upload_status }

  describe Flickr::Person::UploadStatus do
    it "has correct attributes" do
      test_attributes(@upload_status, ATTRIBUTES[:upload_status])
      test_attributes(@upload_status.current_month, ATTRIBUTES[:upload_status_month])
    end
  end
end

ATTRIBUTES[:upload_status] = {
  maximum_photo_size: proc { be_a(Integer) },
}

ATTRIBUTES[:upload_status_month] = {
  maximum:   proc { be_a(Integer) },
  used:      proc { be_a(Integer) },
  remaining: proc { be_a(Integer) },
}
