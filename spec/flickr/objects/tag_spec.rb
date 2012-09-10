require "spec_helper"

TAG = {
  id:           proc { be_a_nonempty(String) },
  raw:          proc { be_a_nonempty(String) },
  content:      proc { be_a_nonempty(String) },
  machine_tag?: proc { be_a_boolean }
}

describe Flickr::Tag, :vcr do
  context "flickr.photos.getInfo" do
    it "has correct attributes" do
      media = Flickr::Media.find(PHOTO_ID)
      media.get_info!

      TAG.each do |attribute, test|
        media.tags.first.send(attribute).should instance_eval(&test)
      end
    end
  end
end
