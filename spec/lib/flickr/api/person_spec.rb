require "spec_helper"

describe Flickr::Api::Person do
  let(:it) { described_class.new(Flickr.access_token) }
  record_api_methods

  describe "#find_by_email" do
    it "returns a person" do
      person = it.find_by_email("flickriegem@yahoo.com")
      expect(person).to be_a(Flickr::Object::Person)
    end
  end

  describe "#find_by_username" do
    it "returns a person" do
      person = it.find_by_username("@janko-m")
      expect(person).to be_a(Flickr::Object::Person)
    end
  end

  describe "#get_upload_status" do
    it "returns the upload status" do
      status = it.get_upload_status
      expect(status).to be_a(Flickr::Object::Person::UploadStatus)
    end
  end

  describe "#get_info" do
    it "returns a person" do
      person = it.get_info("78733179@N04")
      expect(person).to be_a(Flickr::Object::Person)
    end
  end

  describe "#get_photos" do
    it "returns a list of photos" do
      photos = it.get_photos("78733179@N04")
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_photos_of" do
    it "returns a list of photos" do
      photos = it.get_photos_of("78733179@N04")
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_public_photos" do
    it "returns a list of photos" do
      photos = it.get_public_photos("78733179@N04")
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_public_photos_from_contacts" do
    it "returns a list of photos" do
      photos = it.get_public_photos_from_contacts("78733179@N04", include_self: 1)
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_sets" do
    it "returns a list of sets" do
      sets = it.get_sets("78733179@N04")
      expect(sets).to be_a_list_of(Flickr::Object::Set)
    end
  end
end
