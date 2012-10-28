require "spec_helper"

SET_ATTRIBUTES = {
  id:               proc { be_a_nonempty(String) },
  secret:           proc { be_a_nonempty(String) },
  server:           proc { be_a_nonempty(String) },
  farm:             proc { be_a(Integer) },
  url:              proc { be_a_nonempty(String) },
  title:            proc { be_a_nonempty(String) },
  description:      proc { be_a_nonempty(String) },
  owner:            proc { be_a(Flickr::Person) },
  media_count:      proc { be_a(Integer) },
  views_count:      proc { be_a(Integer) },
  comments_count:   proc { be_a(Integer) },
  photos_count:     proc { be_a(Integer) },
  videos_count:     proc { be_a(Integer) },
  created_at:       proc { be_a(Time) },
  updated_at:       proc { be_a(Time) },
  primary_media_id: proc { be_a_nonempty(String) },
  primary_photo:    proc { be_a(Flickr::Photo) },
  primary_video:    proc { be_a(Flickr::Video) },
}

describe Flickr::Set do
  describe "attributes" do
    context "flickr.photosets.create and flickr.photosets.delete" do
      before(:all) { @it = Flickr.sets.create(title: "Title", primary_photo_id: PHOTO_ID) }
      subject { @it }

      test_attributes(SET_ATTRIBUTES.only(:id, :url))

      after(:all) { @it.delete }
    end

    context "flickr.photosets.getInfo" do
      before(:all) { @it = Flickr.sets.find(SET_ID).get_info! }
      subject { @it }

      test_attributes(SET_ATTRIBUTES)
    end

    context "flickr.photosets.getList" do
      before(:all) { @it = Flickr.people.find(USER_ID).get_sets.find(SET_ID) }
      subject { @it }

      test_attributes(SET_ATTRIBUTES.except(:owner, :url))
    end
  end
end
