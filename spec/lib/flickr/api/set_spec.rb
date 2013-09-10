require "spec_helper"

describe Flickr::Api::Set do
  let(:it) { described_class.new(Flickr.access_token) }
  record_api_methods

  describe "#create" do
    it "returns a set" do
      set = it.create(title: "Set", primary_photo_id: "8130464513")
      expect(set).to be_a(Flickr::Object::Set)
    end
  end

  describe "#order" do
    it "makes the API call" do
      it.order("72157636216289703")
    end
  end

  describe "#delete" do
    it "makes the API call" do
      it.delete("72157636218244365")
    end
  end

  describe "#edit_photos" do
    it "makes the API call" do
      it.edit_photos("72157636216289703", primary_photo_id: "8130464513", photo_ids: "8130464513")
    end
  end

  describe "#get_info" do
    it "returns a set" do
      set = it.get_info("72157636216289703")
      expect(set).to be_a(Flickr::Object::Set)
    end
  end

  describe "#get_photos" do
    it "returns a list of photos" do
      photos = it.get_photos("72157636216289703")
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#add_photo" do
    it "makes the API call" do
      it.add_photo("72157636216289703", "10101322155")
    end
  end

  describe "#remove_photos" do
    it "makes the API call" do
      it.remove_photos("72157636216289703", "10101322155")
    end
  end

  describe "#remove_photo" do
    it "makes the API call" do
      it.remove_photo("72157636216289703", "10101322155")
    end
  end

  describe "#edit_meta" do
    it "makes the API call" do
      it.edit_meta("72157636216289703", title: "Set")
    end
  end

  # Causes OAuth errors for some reason
  describe "#reorder_photos" do
    it "makes the API call" do
      # it.reorder_photos("72157636216289703", photo_ids: "8130464513")
    end
  end

  describe "#set_primary_photo" do
    it "makes the API call" do
      it.set_primary_photo("72157636216289703", "8130464513")
    end
  end
end
