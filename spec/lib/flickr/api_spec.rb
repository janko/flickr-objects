require "spec_helper"

describe Flickr::Api do
  let(:it) { Flickr }
  record_api_methods

  it "provides interface for API calls" do
    expect(it.photos).to         be_a(Flickr::Api::Photo)
    expect(it.people).to         be_a(Flickr::Api::Person)
    expect(it.sets).to           be_a(Flickr::Api::Set)
    expect(it.upload_tickets).to be_a(Flickr::Api::UploadTicket)
    expect(it.licenses).to       be_a(Flickr::Api::License)
  end

  describe "#upload" do
    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::General).to receive(:upload).and_call_original
      it.upload(photo_path)
    end
  end

  describe "#replace" do
    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::General).to receive(:replace).and_call_original
      it.replace(photo_path, "10100736393")
    end
  end

  describe "#check_upload_tickets" do
    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::UploadTicket).to receive(:check).and_call_original
      it.check_upload_tickets("78701040-72157636215045495")
    end

    it "is deprecated" do
      expect(Flickr).to receive(:deprecation_warn)
      it.check_upload_tickets("78701040-72157636215045495")
    end
  end

  describe "#get_methods" do
    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::General).to receive(:get_methods).and_call_original
      it.get_methods
    end
  end

  describe "#test_login" do
    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::General).to receive(:test_login).and_call_original
      it.test_login
    end
  end

  describe "#test_echo" do
    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::General).to receive(:test_echo).and_call_original
      it.test_echo
    end
  end

  describe "#test_null" do
    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::General).to receive(:test_null).and_call_original
      it.test_null
    end
  end
end
