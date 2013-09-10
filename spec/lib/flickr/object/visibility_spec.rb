require "spec_helper"

describe Flickr::Object::Visibility do
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
             "flickr.photos.recentlyUpdated" do
      object -> { self[0].visibility },
        %w[public friends family]
    end
    api_call "flickr.photos.getInfo" do
      object -> { self.visibility },
        %w[public friends family]
    end
  end
end
