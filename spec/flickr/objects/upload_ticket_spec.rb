require "spec_helper"

describe Flickr::UploadTicket do
  use_vcr_cassette

  it "doesn't initialize the photo when ID isn't present" do
    ticket = Flickr.upload_tickets.check(1).first
    ticket.photo.should be_nil
  end
end
