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

  it "initializes a collection of tickets" do
    @response.should be_a(Flickr::Collection)
  end

  describe Flickr::UploadTicket do
    it "has correct attributes" do
      test_attributes(@ticket, ATTRIBUTES[:upload_ticket])
    end
  end

  describe Flickr::Media do
    it "has correct attributes" do
      test_attributes(@ticket.media, ATTRIBUTES[:media].slice(:id))
      test_attributes(@ticket.photo, ATTRIBUTES[:media].slice(:id))
      test_attributes(@ticket.video, ATTRIBUTES[:media].slice(:id))
    end
  end

  it "has aliases" do
    Flickr.check_upload_tickets(@id)
  end
end
