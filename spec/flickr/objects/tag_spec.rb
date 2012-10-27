require "spec_helper"

TAG_ATTRIBUTES = {
  id:           proc { be_a_nonempty(String) },
  raw:          proc { be_a_nonempty(String) },
  content:      proc { be_a_nonempty(String) },
  machine_tag?: proc { be_a_boolean }
}

describe Flickr::Tag do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @it = Flickr.media.find(PHOTO_ID).get_info!.tags.first }
      subject { @it }

      TAG_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end

    context "flickr.photos.search" do
      before(:all) { @it = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID).tags.first }
      subject { @it }

      TAG_ATTRIBUTES.only(:content, :machine_tag?).each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
