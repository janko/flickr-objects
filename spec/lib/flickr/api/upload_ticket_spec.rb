require "spec_helper"

describe Flickr::Api::UploadTicket do
  let(:it) { described_class.new(Flickr.access_token) }
  record_api_methods

  describe "#check" do
    it "returns a list of tickets" do
      tickets = it.check("78701040-72157636215045495")
      expect(tickets).to be_a_list_of(Flickr::Object::UploadTicket)
    end
  end
end
