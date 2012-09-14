require "spec_helper"

PERMISSIONS = {
  can_comment?:  proc { be_a_boolean },
  can_add_meta?: proc { be_a_boolean },
  can_download?: proc { be_a_boolean },
  can_blog?:     proc { be_a_boolean },
  can_print?:    proc { be_a_boolean },
  can_share?:    proc { be_a_boolean }
}

describe Flickr::Permissions, :vcr do
  context "flickr.photos.getInfo" do
    let(:media) { Flickr::Media.find(PHOTO_ID).get_info! }

    it "has correct attributes" do
      PERMISSIONS.slice(:can_comment?, :can_add_meta?).each do |attribute, test|
        media.editability.send(attribute).should instance_eval(&test)
        media.public_editability.send(attribute).should instance_eval(&test)
      end

      PERMISSIONS.slice(:can_download?, :can_blog?, :can_print?, :can_share?).each do |attribute, test|
        media.usage.send(attribute).should instance_eval(&test)
      end
    end
  end
end
