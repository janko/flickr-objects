require "spec_helper"

PERMISSIONS_ATTRIBUTES = {
  can_comment?:  proc { be_a_boolean },
  can_add_meta?: proc { be_a_boolean },
  can_download?: proc { be_a_boolean },
  can_blog?:     proc { be_a_boolean },
  can_print?:    proc { be_a_boolean },
  can_share?:    proc { be_a_boolean }
}

describe Flickr::Permissions do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @media = Flickr.media.find(PHOTO_ID).get_info! }

      describe "editability" do
        before(:each) { @it = @media.editability }
        subject { @it }

        test_attributes(PERMISSIONS_ATTRIBUTES.only(:can_comment?, :can_add_meta?))
      end

      describe "public_editability" do
        before(:each) { @it = @media.public_editability }
        subject { @it }

        test_attributes(PERMISSIONS_ATTRIBUTES.only(:can_comment?, :can_add_meta?))
      end

      describe "usage" do
        before(:each) { @it = @media.usage }
        subject { @it }

        test_attributes(PERMISSIONS_ATTRIBUTES.only(:can_download?, :can_blog?, :can_print?, :can_share?))
      end
    end

    context "flickr.photosets.getInfo" do
      before(:all) { @it = Flickr.sets.find(SET_ID).get_info!.permissions }
      subject { @it }

      test_attributes(PERMISSIONS_ATTRIBUTES.only(:can_comment?))
    end
  end
end
