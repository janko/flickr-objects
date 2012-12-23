require "spec_helper"

describe "flickr.photos.getContactsPhotos" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.get_from_contacts(include_self: 1)
    @media = @response.first
  }

  it "returns the right kind of collections" do
    @response.should be_a(Flickr::Collection)

    Flickr.media.get_from_contacts(include_self: 1).select { |object| object.is_a?(Flickr::Photo) }.should_not be_empty
    Flickr.media.get_from_contacts(include_self: 1).select { |object| object.is_a?(Flickr::Video) }.should_not be_empty
    Flickr.photos.get_from_contacts(include_self: 1).each { |object| object.should be_a(Flickr::Photo) }
    Flickr.videos.get_from_contacts(include_self: 1).each { |object| object.should be_a(Flickr::Video) }
  end

  it "assigns attributes correctly" do
    @media.id.should be_a_nonempty(String)
  end
end
