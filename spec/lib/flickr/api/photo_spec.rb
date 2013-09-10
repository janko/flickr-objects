require "spec_helper"

describe Flickr::Api::Photo do
  let(:it) { described_class.new(Flickr.access_token) }
  record_api_methods

  describe "#search" do
    it "returns a list of photos" do
      photos = it.search(user_id: "78733179@N04")
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_from_contacts" do
    it "returns a list of photos" do
      photos = it.get_from_contacts(include_self: 1)
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_not_in_set" do
    it "returns a list of photos" do
      photos = it.get_not_in_set
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_recent" do
    it "returns a list of photos" do
      photos = it.get_recent
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_untagged" do
    it "returns a list of photos" do
      photos = it.get_untagged
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_with_geo_data" do
    it "returns a list of photos" do
      photos = it.get_with_geo_data
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_without_geo_data" do
    it "returns a list of photos" do
      photos = it.get_without_geo_data
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_recently_updated" do
    it "returns a list of photos" do
      photos = it.get_recently_updated(min_date: Date.new(2013, 9, 8))
      expect(photos).to be_a_list_of(Flickr::Object::Photo)
    end
  end

  describe "#get_info" do
    it "returns a photo" do
      photo = it.get_info("8130464513")
      expect(photo).to be_a(Flickr::Object::Photo)
    end
  end

  describe "#get_sizes" do
    it "returns a photo" do
      photo = it.get_sizes("10115956703")
      expect(photo).to be_a(Flickr::Object::Photo)
    end
  end

  describe "#get_exif" do
    it "returns a photo" do
      photo = it.get_exif("8130464513")
      expect(photo).to be_a(Flickr::Object::Photo)
    end
  end

  describe "#get_favorites" do
    it "returns a list of people" do
      people = it.get_favorites("7316710626")
      expect(people).to be_a_list_of(Flickr::Object::Person)
    end
  end

  describe "#delete" do
    it "makes the API call" do
      it.delete "10101061645"
    end
  end

  describe "#set_content_type" do
    it "makes the API call" do
      it.set_content_type("8130464513", 1)
    end
  end

  describe "#set_tags" do
    it "makes the API call" do
      it.set_tags("8130464513", "foo")
    end
  end

  describe "#add_tags" do
    it "makes the API call" do
      it.add_tags("8130464513", "foo")
    end
  end

  describe "#remove_tag" do
    it "makes the API call" do
      it.remove_tag("8130464513", "78701040-8130464513-14924")
    end
  end

  describe "#set_dates" do
    it "makes the API call" do
      it.set_dates("8130464513", date_posted: Date.new(2013, 10, 5))
    end
  end

  describe "#set_meta" do
    it "makes the API call" do
      it.set_meta("8130464513", title: "Photo")
    end
  end

  describe "#set_permissions" do
    it "makes the API call" do
      it.set_permissions("8130464513", is_public: 1, is_friend: 1, is_family: 1, perm_comment: 1, perm_addmeta: 1)
    end
  end

  describe "#set_safety_level" do
    it "makes the API call" do
      it.set_safety_level("8130464513", safety_level: 1)
    end
  end
end
