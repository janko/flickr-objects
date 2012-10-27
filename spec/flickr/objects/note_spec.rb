require "spec_helper"

NOTE_ATTRIBUTES = {
  id:          proc { be_a_nonempty(String) },
  coordinates: proc { be_a(Array) },
  width:       proc { be_a(Integer) },
  height:      proc { be_a(Integer) }
}

describe Flickr::Note do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @it = Flickr.media.find(PHOTO_ID).get_info!.notes.first }
      subject { @it }

      test_attributes(NOTE_ATTRIBUTES)
    end
  end
end
