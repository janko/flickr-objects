require "spec_helper"

describe "flickr.photos.getInfo" do
  use_vcr_cassette

  before(:each) {
    @response = Flickr.media.find(MEDIA_ID).get_info!
    @media = @response
    @photo = Flickr.photos.find(PHOTO_ID).get_info!
    @video = Flickr.videos.find(VIDEO_ID).get_info!
    @note = @media.notes.first
    @tag = @media.tags.first
  }

  describe Flickr::Media do
    it "has correct attributes" do
      test_attributes(@media, ATTRIBUTES[:media])
    end
  end

  describe Flickr::Photo do
    it "has correct attributes" do
      test_attributes(@photo, ATTRIBUTES[:photo])
    end
  end

  describe Flickr::Video do
    it "has correct attributes" do
      test_attributes(@video, ATTRIBUTES[:video].except(:source_url, :download_url, :mobile_download_url))
    end
  end

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@media.owner, ATTRIBUTES[:person].slice(:id, :nsid, :username, :real_name, :location, :icon_server, :icon_farm))
      test_attributes(@note.author, ATTRIBUTES[:person].slice(:id, :nsid, :username))
      test_attributes(@tag.author, ATTRIBUTES[:person].slice(:id, :nsid))
    end
  end

  describe Flickr::Tag do
    it "has correct attributes" do
      test_attributes(@tag, ATTRIBUTES[:tag])
    end
  end

  describe Flickr::Note do
    it "has correct attributes" do
      test_attributes(@note, ATTRIBUTES[:note])
    end
  end

  describe Flickr::Visibility do
    it "has correct attributes" do
      test_attributes(@media.visibility, ATTRIBUTES[:visibility].slice(:public?, :friends?, :family?))
    end
  end

  describe Flickr::Permissions do
    it "has correct attributes" do
      test_attributes(@media.editability, ATTRIBUTES[:permissions].slice(:can_comment?, :can_add_meta?))
      test_attributes(@media.public_editability, ATTRIBUTES[:permissions].slice(:can_comment?, :can_add_meta?))
      test_attributes(@media.usage, ATTRIBUTES[:permissions].slice(:can_download?, :can_blog?, :can_print?, :can_share?))
    end
  end

  describe Flickr::Location do
    it "has correct attributes" do
      test_attributes(@media.location, ATTRIBUTES[:location])
    end

    describe Flickr::Location::Area do
      [:neighbourhood, :locality, :county, :region, :country].each do |area|
        it "has correct attributes" do
          test_attributes(@media.location.send(area), ATTRIBUTES[:area])
        end
      end
    end
  end
end
