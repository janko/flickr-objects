require "spec_helper"

describe Flickr::Object::Photo::Tag do
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
             "flickr.photos.getWithGeoData",
             "flickr.photos.getWithoutGeoData",
             "flickr.photos.recentlyUpdated",
             "flickr.photosets.getPhotos" do
      object -> { self[0].tags[0] },
        %w[content machine_tag]
    end
    api_call "flickr.photos.getInfo" do
      object -> { self.tags[0] },
        %w[id raw content machine_tag]
    end
  end
end
