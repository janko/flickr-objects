require "spec_helper"

describe Flickr, :vcr do
  describe "flickr.photos.getContactsPhotos" do
    it "should return photos or videos" do
      Flickr.get_contacts_photos(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Photo) }
      Flickr.get_contacts_videos(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Video) }
    end
  end

  describe "flickr.photos.getPublicContactsPhotos" do
    it "should return photos or videos" do
      Flickr::Person.find(USER_ID).get_contacts_public_photos(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Photo) }
      Flickr::Person.find(USER_ID).get_contacts_public_videos(include_self: 1, extras: EXTRAS).each { |object| object.should be_a(Flickr::Video) }
    end
  end

  describe "flickr.test.echo" do
    before(:all) { @response = make_request("flickr.test.echo") }
    subject { @response }

    it { should be_a_nonempty(Hash) }
  end

  describe "flickr.test.null" do
    before(:all) { @response = make_request("flickr.test.null") }
    subject { @response }
  end
end
