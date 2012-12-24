require "spec_helper"

describe "flickr.photos.upload.checkTickets" do
  use_vcr_cassette

  before(:each) {
    @id = Flickr.upload file("photo.jpg"), async: 1
    # sleep 3
    @response = Flickr.upload_tickets.check(@id)
    @ticket = @response.first
  }

  after(:each) { @ticket.photo.delete }

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

  it "has aliases" do
    Flickr.check_upload_tickets(@id)
  end
end
