require "spec_helper"

describe Flickr::Api::General do
  let(:it) { described_class.new(Flickr.access_token) }
  record_api_methods

  describe "#upload", :vcr do
    it "sanitizes the photo" do
      it.upload photo_path
    end

    it "accepts any IO-like object" do
      it.upload FakeIO.new(File.read(photo_path))
    end

    it "returns the photo ID when synchronous" do
      value = it.upload photo_path, async: 0
      expect(value).to be_a_nonempty(String)
    end

    it "returns the ticket ID when asynchronous" do
      value = it.upload photo_path, async: 1
      expect(value).to be_a_nonempty(String)
    end
  end

  describe "#replace", :vcr do
    it "sanitizes the photo" do
      it.replace photo_path, "10100895983"
    end

    it "returns the photo ID when synchronous" do
      value = it.replace photo_path, "10100895983", async: 0
      expect(value).to be_a_nonempty(String)
    end

    it "returns the ticket ID when asynchronous" do
      value = it.replace photo_path, "10100895983", async: 1
      expect(value).to be_a_nonempty(String)
    end
  end

  describe "#get_methods" do
    it "parses the response" do
      methods = it.get_methods
      expect(methods).to include("flickr.reflection.getMethods")
    end
  end

  describe "#test_login" do
    it "makes the request" do
      response = it.test_login
      expect(response).to be_a(Hash)
    end
  end

  describe "#test_echo" do
    it "makes the request" do
      response = it.test_echo
      expect(response).to be_a(Hash)
    end
  end

  describe "#test_null" do
    it "makes the request" do
      response = it.test_null
      expect(response).to be_a(Hash)
    end
  end
end
