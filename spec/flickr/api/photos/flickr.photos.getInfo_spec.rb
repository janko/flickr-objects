require "spec_helper"

describe "flickr.photos.getInfo", :api_method do
  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID).get_info!
    @note = @photo.notes.first
    @tag = @photo.tags.first
  }

  describe Flickr::Photo do
    it "has correct attributes" do
      test_attributes(@photo, ATTRIBUTES[:photo])
    end

    describe Flickr::Photo::Tag do
      it "has correct attributes" do
        test_attributes(@tag, ATTRIBUTES[:tag])
      end
    end

    describe Flickr::Photo::Note do
      it "has correct attributes" do
        test_attributes(@note, ATTRIBUTES[:note])
      end
    end
  end

  describe Flickr::Person do
    it "has correct attributes" do
      test_attributes(@photo.owner, ATTRIBUTES[:person].slice(:id, :nsid, :username, :real_name, :location, :icon_server, :icon_farm))
      test_attributes(@note.author, ATTRIBUTES[:person].slice(:id, :nsid, :username))
      test_attributes(@tag.author, ATTRIBUTES[:person].slice(:id, :nsid))
    end
  end

  describe Flickr::Visibility do
    it "has correct attributes" do
      test_attributes(@photo.visibility, ATTRIBUTES[:visibility].slice(:public?, :friends?, :family?))
    end
  end

  describe Flickr::Permissions do
    it "has correct attributes" do
      test_attributes(@photo.editability, ATTRIBUTES[:permissions].slice(:can_comment?, :can_add_meta?))
      test_attributes(@photo.public_editability, ATTRIBUTES[:permissions].slice(:can_comment?, :can_add_meta?))
      test_attributes(@photo.usage, ATTRIBUTES[:permissions].slice(:can_download?, :can_blog?, :can_print?, :can_share?))
    end
  end

  describe Flickr::Location do
    it "has correct attributes" do
      test_attributes(@photo.location, ATTRIBUTES[:location])
    end

    describe Flickr::Location::Area do
      [:neighbourhood, :locality, :county, :region, :country].each do |area|
        it "has correct attributes" do
          test_attributes(@photo.location.send(area), ATTRIBUTES[:area])
        end
      end
    end
  end
end
