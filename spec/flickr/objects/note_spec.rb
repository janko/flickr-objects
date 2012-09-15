require "spec_helper"

NOTE_ATTRIBUTES = {
  id:          proc { be_a_nonempty(String) },
  coordinates: proc { be_a(Array) },
  width:       proc { be_a(Integer) },
  height:      proc { be_a(Integer) }
}

describe Flickr::Note, :vcr do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @note = make_request("flickr.photos.getInfo").notes.first }
      subject { @note }

      NOTE_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
