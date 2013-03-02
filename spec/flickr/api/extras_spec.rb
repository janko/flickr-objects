require "spec_helper"

# It tests common attributes for all API calls that have :extras
describe "Extras", :vcr do
  before(:each) {
    @response = Flickr.photos.search(user_id: PERSON_ID, extras: EXTRAS)
    @photo = @response.find(PHOTO_ID)
  }

  describe Flickr::Photo do
    it "has correct attributes" do
      test_attributes(@photo, ATTRIBUTES[:photo].slice(:id, :secret, :server, :farm, :uploaded_at, :license, :title, :description, :taken_at, :taken_at_granularity, :updated_at, :views_count, :path_alias))
    end

    describe Flickr::Photo::Tag do
      it "has correct attributes" do
        test_attributes(@photo.tags.first, ATTRIBUTES[:tag].slice(:content, :machine_tag?))
      end
    end
  end

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@photo.owner, ATTRIBUTES[:person].slice(:id, :nsid, :username, :icon_server, :icon_farm))
    end
  end

  describe Flickr::Visibility do
    it "has correct attributes" do
      test_attributes(@photo.visibility, ATTRIBUTES[:visibility].slice(:public?, :friends?, :family?))
    end
  end

  describe Flickr::Location do
    it "has correct attributes" do
      test_attributes(@photo.location, ATTRIBUTES[:location])
    end
  end
end
