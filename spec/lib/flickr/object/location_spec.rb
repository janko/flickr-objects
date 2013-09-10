require "spec_helper"

describe Flickr::Object::Location do
  let(:it) { described_class.new({}) }
  record_api_methods

  test_attributes do
    api_call "flickr.people.getPhotos",
             "flickr.people.getPhotosOf",
             "flickr.people.getPublicPhotos",
             "flickr.people.getContactsPublicPhotos",
             "flickr.photos.search",
             "flickr.photos.getContactsPhotos",
             "flickr.photos.getNotInSet",
             "flickr.photos.getRecent",
             "flickr.photos.getUntagged",
             "flickr.photos.getWithGeoData",
             "flickr.photos.getWithoutGeoData",
             "flickr.photos.recentlyUpdated",
             "flickr.photosets.getPhotos" do
      object -> { self[0].location },
        %w[latitude longitude accuracy context indoors outdoors]
    end
    api_call "flickr.photos.getInfo" do
      object -> { self.location },
        %w[latitude longitude accuracy context place_id woe_id
           indoors outdoors]
    end
  end
end

describe Flickr::Object::Location::Area do
  let(:it) { described_class.new({}) }
  record_api_methods

  test_attributes do
    api_call "flickr.photos.getInfo" do
      # object -> { self.location.neighbourhood },
      #   %w[name place_id woe_id]
      object -> { self.location.locality },
        %w[name place_id woe_id]
      object -> { self.location.county },
        %w[name place_id woe_id]
      object -> { self.location.region },
        %w[name place_id woe_id]
      object -> { self.location.country },
        %w[name place_id woe_id]
    end
  end
end
