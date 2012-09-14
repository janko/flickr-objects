require "spec_helper"

TAG = {
  id:           proc { be_a_nonempty(String) },
  raw:          proc { be_a_nonempty(String) },
  content:      proc { be_a_nonempty(String) },
  machine_tag?: proc { be_a_boolean }
}

describe Flickr::Tag, :vcr do
  context "flickr.photos.getInfo" do
    let(:media) { Flickr::Media.find(PHOTO_ID).get_info! }

    it "has correct attributes" do
      TAG.each do |attribute, test|
        media.tags.first.send(attribute).should instance_eval(&test)
      end
    end
  end

  context "flickr.photos.search" do
    let(:media) { Flickr::Media.search(user_id: USER_ID, extras: EXTRAS).first }

    it "has correct attributes" do
      TAG.except(:raw, :id).each do |attribute, test|
        media.tags.first.send(attribute).should instance_eval(&test)
      end
    end
  end
end
