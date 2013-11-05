require "spec_helper"

describe Flickr::Object::Person do
  let(:it) { described_class.new({}, Flickr.access_token) }
  record_api_methods

  describe "#get_info!" do
    before { it.update("id" => "78733179@N04") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Person).to receive(:get_info).and_call_original
      it.get_info!
    end

    it "updates the photo with the reponse from the API call" do
      it.get_info!
      expect(it.username).to be_a(String)
    end
  end

  describe "#get_photos" do
    before { it.update("id" => "78733179@N04") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Person).to receive(:get_photos).and_call_original
      it.get_photos
    end
  end

  describe "#get_photos_of" do
    before { it.update("id" => "78733179@N04") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Person).to receive(:get_photos_of).and_call_original
      it.get_photos_of
    end
  end

  describe "#get_public_photos" do
    before { it.update("id" => "78733179@N04") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Person).to receive(:get_public_photos).and_call_original
      it.get_public_photos
    end
  end

  describe "#get_public_photos_from_contacts" do
    before { it.update("id" => "78733179@N04") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Person).to receive(:get_public_photos_from_contacts).and_call_original
      it.get_public_photos_from_contacts
    end
  end

  describe "#get_sets" do
    before { it.update("id" => "78733179@N04") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Person).to receive(:get_sets).and_call_original
      it.get_sets
    end
  end

  test_attributes do
    api_call "flickr.people.findByEmail" do
      object -> { self },
        %w[id nsid username]
    end
    api_call "flickr.people.findByUsername" do
      object -> { self },
        %w[id nsid username]
    end
    api_call "flickr.people.getInfo" do
      object -> { self },
        %w[id nsid username has_pro_account icon_server icon_farm real_name
           location time_zone description photos_url profile_url mobile_url
           first_photo_taken first_photo_uploaded buddy_icon_url photos_count
           photo_views_count]
    end
    api_call "flickr.people.getPhotos",
             "flickr.people.getPhotosOf",
             "flickr.people.getPublicPhotos",
             "flickr.people.getContactsPublicPhotos",
             "flickr.photos.search",
             "flickr.photos.getContactsPhotos",
             "flickr.photos.getNotInSet",
             "flickr.photos.getRecent",
             "flickr.interestingness.getList",
             "flickr.photos.getUntagged",
             "flickr.photos.getWithGeoData",
             "flickr.photos.getWithoutGeoData",
             "flickr.photos.recentlyUpdated",
             "flickr.photosets.getPhotos" do
      object -> { self[0].owner },
        %w[id nsid username icon_server icon_farm]
    end
    api_call "flickr.photos.getFavorites" do
      object -> { self[0] },
        %w[id nsid username icon_server icon_farm favorited_at]
    end
    api_call "flickr.photos.getInfo" do
      object -> { self.owner },
        %w[id nsid username real_name location icon_server icon_farm path_alias]
      object -> { self.tags[0].author },
        %w[id nsid]
      object -> { self.notes[0].author },
        %w[id nsid username]
    end
  end
end
