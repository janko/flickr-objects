require "spec_helper"

# It tests common attributes for all API calls that have :extras
describe "Extras" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.photos.search(user_id: PERSON_ID, extras: EXTRAS)
    @media = @response.find(MEDIA_ID)
    @person = @media.owner
    @visibility = @media.visibility
    @location = @media.location
    @tag = @media.tags.first
  }

  describe Flickr::Media do
    it "has correct attributes" do
      test_attributes(@media, ATTRIBUTES[:media].slice(:id, :secret, :server, :farm, :uploaded_at, :license, :title, :description, :taken_at, :taken_at_granularity, :updated_at, :views_count, :path_alias))
    end
  end

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@person, ATTRIBUTES[:person].slice(:id, :nsid, :username, :icon_server, :icon_farm))
    end
  end

  describe Flickr::Visibility do
    it "has correct attributes" do
      test_attributes(@visibility, ATTRIBUTES[:visibility].slice(:public?, :friends?, :family?))
    end
  end

  describe Flickr::Location do
    it "has correct attributes" do
      test_attributes(@location, ATTRIBUTES[:location])
    end
  end

  describe Flickr::Tag do
    it "has correct attributes" do
      test_attributes(@tag, ATTRIBUTES[:tag].slice(:content, :machine_tag?))
    end
  end
end
