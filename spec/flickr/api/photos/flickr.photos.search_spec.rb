require "spec_helper"

describe "flickr.people.search" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.media.search(user_id: PERSON_ID, extras: EXTRAS)
    @media = @response.find(MEDIA_ID)
  end

  it "returns a right kind of collections" do
    @response.should be_a(Flickr::Collection)

    Flickr.media.search(user_id: PERSON_ID, extras: EXTRAS).select { |object| object.is_a?(Flickr::Photo) }.should_not be_empty
    Flickr.media.search(user_id: PERSON_ID, extras: EXTRAS).select { |object| object.is_a?(Flickr::Video) }.should_not be_empty
    Flickr.photos.search(user_id: PERSON_ID, extras: EXTRAS).each { |object| object.should be_a(Flickr::Photo) }
    Flickr.videos.search(user_id: PERSON_ID, extras: EXTRAS).each { |object| object.should be_a(Flickr::Video) }
  end

  it "assigns attributes correctly" do
    @media.id.should be_a_nonempty(String)
  end
end
