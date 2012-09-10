require "spec_helper"

NOTE = {
  id:          proc { be_a_nonempty(String) },
  coordinates: proc { be_a(Array) },
  width:       proc { be_a(Integer) },
  height:      proc { be_a(Integer) }
}

describe Flickr::Note, :vcr do
  context "flickr.photos.getInfo" do
    it "has correct attributes" do
      media = Flickr::Media.find(PHOTO_ID)
      media.get_info!

      NOTE.each do |attribute, test|
        media.notes.first.send(attribute).should instance_eval(&test)
      end
    end
  end
end
