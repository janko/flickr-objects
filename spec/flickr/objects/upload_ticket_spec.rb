require "spec_helper"

describe Flickr::UploadTicket do
  use_vcr_cassette

  it "doesn't initialize the media when ID isn't present" do
    ticket = Flickr.upload_tickets.check(1).first
    %w[media photo video].each { |method| ticket.send(method).should be_nil }
  end
end
