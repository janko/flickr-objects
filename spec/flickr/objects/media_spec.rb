require "spec_helper"

MEDIA_ATTRIBUTES = {
  id:                   proc { be_a_nonempty(String) },
  secret:               proc { be_a_nonempty(String) },
  server:               proc { be_a_nonempty(String) },
  farm:                 proc { be_a(Fixnum) },
  uploaded_at:          proc { be_a(Time) },
  favorite?:            proc { be_a_boolean },
  license:              proc { be_a(Fixnum) },
  safety_level:         proc { be_a(Fixnum) },
  title:                proc { be_a_nonempty(String) },
  description:          proc { be_a_nonempty(String) },
  posted_at:            proc { be_a(Time) },
  taken_at:             proc { be_a(Time) },
  taken_at_granularity: proc { be_a(Fixnum) },
  updated_at:           proc { be_a(Time) },
  views_count:          proc { be_a(Fixnum) },
  comments_count:       proc { be_a(Fixnum) },
  has_people?:          proc { be_a_boolean },
  path_alias:           proc { be_nil }
}

describe Flickr::Media do
  describe "methods" do
    before(:all) { @it = Flickr.media.find(PHOTO_ID).get_info! }
    subject { @it }

    [:safe?, :moderate?, :restricted?].each do |safety_level|
      its(safety_level) { should be_a_boolean }
    end

    its(:url) { should be_a_nonempty(String) }

    it "has a short URL" do
      @it.short_url.should be_an_existing_url
    end
  end

  describe "attributes" do
    def self.test_extras(attributes)
      test_attributes(attributes.except(:favorite?, :safety_level, :posted_at, :comments_count, :has_people?))
    end

    context "flickr.photos.getContactsPhotos" do
      before(:all) { @it = Flickr.photos.get_from_contacts(extras: EXTRAS, include_self: 1).first }
      subject { @it }

      test_extras(MEDIA_ATTRIBUTES)
    end

    context "flickr.photos.getInfo" do
      before(:all) { @it = Flickr.photos.find(PHOTO_ID).get_info! }
      subject { @it }

      test_attributes(MEDIA_ATTRIBUTES)
    end

    context "flickr.photos.search" do
      before(:all) { @it = Flickr.photos.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID) }
      subject { @it }

      test_extras(MEDIA_ATTRIBUTES)
    end

    context "flickr.photosets.getPhotos" do
      before(:all) { @it = Flickr.sets.find(SET_ID).get_photos(extras: EXTRAS).first }
      subject { @it }

      test_extras(MEDIA_ATTRIBUTES)
    end

    context "flickr.photosets.getInfo" do
      before(:all) { @it = Flickr.sets.find(SET_ID).get_info!.primary_photo }
      subject { @it }

      test_attributes(MEDIA_ATTRIBUTES.only(:id))
    end

    context "flickr.people.getPhotos" do
      before(:all) { @it = Flickr.people.find(USER_ID).get_photos(extras: EXTRAS).find(PHOTO_ID) }
      subject { @it }

      test_extras(MEDIA_ATTRIBUTES)
    end

    context "flickr.people.getPublicPhotos" do
      before(:all) { @it = Flickr.people.find(USER_ID).get_public_photos(extras: EXTRAS).find(PHOTO_ID) }
      subject { @it }

      test_extras(MEDIA_ATTRIBUTES)
    end
  end
end
