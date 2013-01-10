require "spec_helper"

describe "flickr.photos.upload.checkTickets", :api_method do
  before(:each) {
    @id = Flickr.upload file("photo.jpg"), async: 1
    # sleep 3
    @response = Flickr.upload_tickets.check(@id)
    @ticket = @response.first
  }

  it "returns a Flickr::List" do
    @response.should be_a(Flickr::List)
  end

  describe Flickr::UploadTicket do
    it "has correct attributes" do
      test_attributes(@ticket, ATTRIBUTES[:upload_ticket])
    end
  end

  describe Flickr::Photo do
    it "has correct attributes" do
      test_attributes(@ticket.photo, ATTRIBUTES[:photo].slice(:id))
    end
  end

  after(:each) { @ticket.photo.delete }
end

ATTRIBUTES[:upload_ticket] = {
  id:        proc { be_a_nonempty(String) },
  status:    proc { be_a(Integer) },
  invalid?:  proc { be_a_boolean },
  complete?: proc { be_a_boolean },
  failed?:   proc { be_a_boolean },
  photo:     proc { be_a(Flickr::Photo) },
}
