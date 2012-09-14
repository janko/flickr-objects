require "spec_helper"

VISIBILITY = {
  public?:  proc { be_a_boolean },
  friends?: proc { be_a_boolean },
  family?:  proc { be_a_boolean }
}

describe Flickr::Visibility, :vcr do
  context "flickr.photos.getInfo" do
    let(:media) { Flickr::Media.find(PHOTO_ID).get_info! }

    it "has correct attributes" do
      VISIBILITY.each do |attribute, test|
        media.visibility.send(attribute).should instance_eval(&test)
      end
    end
  end

  context "flickr.photos.search" do
    let(:media) { Flickr::Media.search(user_id: USER_ID, extras: EXTRAS).first }

    it "has correct attributes" do
      VISIBILITY.each do |attribute, test|
        media.visibility.send(attribute).should instance_eval(&test)
      end
    end
  end
end
