require "spec_helper"

describe Flickr::Object::UploadTicket do
  let(:it) { described_class.new({}, Flickr.access_token) }
  record_api_methods

  describe "#get_info!" do
    before { it.update("id" => "78701040-72157636215045495") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::UploadTicket).to receive(:check).and_call_original
      it.get_info!
    end

    it "updates the upload ticket from the response of the API method" do
      it.get_info!
      expect(it.valid?).to eq true
    end
  end

  test_attributes do
    api_call "flickr.photos.upload.checkTickets" do
      object -> { self[0] },
        %w[id status complete failed valid invalid]
    end
  end
end
