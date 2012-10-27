require "spec_helper"

PERSON_ATTRIBUTES = {
  id:                   proc { be_a_nonempty(String) },
  nsid:                 proc { be_a_nonempty(String) },
  username:             proc { be_a_nonempty(String) },
  real_name:            proc { be_a_nonempty(String) },
  location:             proc { be_a_nonempty(String) },
  icon_server:          proc { be_a(Fixnum) },
  icon_farm:            proc { be_a(Fixnum) },
  pro?:                 proc { be_a_boolean },
  path_alias:           proc { be_nil },
  location:             proc { be_a_nonempty(String) },
  time_zone:            proc { be_a_nonempty(Hash) },
  description:          proc { be_a_nonempty(String) },
  photos_url:           proc { be_a_nonempty(String) },
  videos_url:           proc { be_a_nonempty(String) },
  media_url:            proc { be_a_nonempty(String) },
  profile_url:          proc { be_a_nonempty(String) },
  mobile_url:           proc { be_a_nonempty(String) },
  media_count:          proc { be_a(Integer) },
  photos_count:         proc { be_a(Integer) },
  videos_count:         proc { be_a(Integer) },
  media_views_count:    proc { be_a(Integer) },
  photo_views_count:    proc { be_a(Integer) },
  video_views_count:    proc { be_a(Integer) },
  first_photo_taken:    proc { be_a(Time) },
  first_video_taken:    proc { be_a(Time) },
  first_media_taken:    proc { be_a(Time) },
  first_photo_uploaded: proc { be_a(Time) },
  first_video_uploaded: proc { be_a(Time) },
  first_media_uploaded: proc { be_a(Time) },
}

describe Flickr::Person do
  describe "methods" do
    before(:all) { @it = Flickr.media.find(PHOTO_ID).get_info!.owner }
    subject { @it }

    describe "#buddy_icon_url" do
      context "when person has an avatar" do
        its(:buddy_icon_url) { should be_an_existing_url }
      end

      context "when prerson doesn't have an avatar" do
        before(:each) { @it.stub(:icon_server).and_return(0) }

        its(:buddy_icon_url) { should be_an_existing_url }
      end
    end
  end

  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @media = Flickr.media.find(PHOTO_ID).get_info! }

      describe "photo's owner" do
        before(:each) { @it = @media.owner }
        subject { @it }

        test_attributes(PERSON_ATTRIBUTES.only(:id, :nsid, :username, :real_name, :location, :icon_server, :icon_farm))
      end

      describe "notes' author" do
        before(:each) { @it = @media.notes.first.author }
        subject { @it }

        test_attributes(PERSON_ATTRIBUTES.only(:id, :nsid, :username))
      end

      describe "tags' author" do
        before(:each) { @it = @media.tags.first.author }
        subject { @it }

        test_attributes(PERSON_ATTRIBUTES.only(:id, :nsid))
      end
    end

    context "flickr.photos.search" do
      before(:all) { @it = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID).owner }
      subject { @it }

      test_attributes(PERSON_ATTRIBUTES.only(:id, :nsid, :username, :icon_server, :icon_farm))
    end

    context "flickr.photosets.getInfo" do
      before(:all) { @it = Flickr.sets.find(SET_ID).get_info!.owner }
      subject { @it }

      test_attributes(PERSON_ATTRIBUTES.only(:id, :nsid, :username))
    end

    context "flickr.people.findByEmail" do
      before(:all) { @it = Flickr.people.find_by_email(USER_EMAIL) }
      subject { @it }

      test_attributes(PERSON_ATTRIBUTES.only(:id, :nsid, :username))
    end

    context "flickr.people.findByUsername" do
      before(:all) { @it = Flickr.people.find_by_username(USER_USERNAME) }
      subject { @it }

      test_attributes(PERSON_ATTRIBUTES.only(:id, :nsid, :username))
    end

    context "flickr.people.getInfo" do
      before(:all) { @it = Flickr.people.find(USER_ID).get_info! }
      subject { @it }

      test_attributes(PERSON_ATTRIBUTES)
    end
  end
end
