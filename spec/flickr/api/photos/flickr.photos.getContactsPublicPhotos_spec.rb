require "spec_helper"

describe "flickr.photos.getContactsPublicPhotos" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.people.find(PERSON_ID).get_public_photos_from_contacts(include_self: 1)
    @media = @response.first
  }

  it "returns the right kind of collections" do
    @response.should be_a(Flickr::Collection)

    person = Flickr.people.find(PERSON_ID)
    person.get_public_media_from_contacts(include_self: 1).select { |object| object.is_a?(Flickr::Photo) }.should_not be_empty
    person.get_public_media_from_contacts(include_self: 1).select { |object| object.is_a?(Flickr::Video) }.should_not be_empty
    person.get_public_photos_from_contacts(include_self: 1).each { |object| object.should be_a(Flickr::Photo) }
    person.get_public_videos_from_contacts(include_self: 1).each { |object| object.should be_a(Flickr::Video) }
  end

  it "assigns attributes correctly" do
    @media.id.should be_a_nonempty(String)
  end
end
