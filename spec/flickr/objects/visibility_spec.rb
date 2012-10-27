require "spec_helper"

VISIBILITY_ATTRIBUTES = {
  public?:   proc { be_a_boolean },
  friends?:  proc { be_a_boolean },
  family?:   proc { be_a_boolean },
  contacts?: proc { be_a_boolean }
}

describe Flickr::Visibility do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @media = Flickr.media.find(PHOTO_ID).get_info! }

      describe "visibility" do
        before(:each) { @it = @media.visibility }
        subject { @it }

        test_attributes(VISIBILITY_ATTRIBUTES.except(:contacts?))
      end

      describe "location_visibility" do
        before(:each) { @it = @media.location_visibility }
        subject { @it }

        test_attributes(VISIBILITY_ATTRIBUTES)
      end
    end

    context "flickr.photos.search" do
      before(:all) { @media = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID) }

      describe "visibility" do
        before(:each) { @it = @media.visibility }
        subject { @it }

        test_attributes(VISIBILITY_ATTRIBUTES.except(:contacts?))
      end

      describe "location_visibility" do
        before(:each) { @it = @media.location_visibility }
        subject { @it }

        test_attributes(VISIBILITY_ATTRIBUTES)
      end
    end
  end
end
