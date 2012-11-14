require "spec_helper"

describe Flickr::UploadTicket do
  describe ".check" do
    it "returns a collection of tickets" do
      tickets = Flickr.upload_tickets.check(1)
      tickets.first.should be_invalid
    end
  end
end
