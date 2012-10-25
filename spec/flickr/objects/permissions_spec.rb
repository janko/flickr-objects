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
        subject { @media.editability }

        PERMISSIONS_ATTRIBUTES.only(:can_comment?, :can_add_meta?).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "public_editability" do
        subject { @media.public_editability }

        PERMISSIONS_ATTRIBUTES.only(:can_comment?, :can_add_meta?).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "usage" do
        subject { @media.usage }

        PERMISSIONS_ATTRIBUTES.only(:can_download?, :can_blog?, :can_print?, :can_share?).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end
    end
  end
end
