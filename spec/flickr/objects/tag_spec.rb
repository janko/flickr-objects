require "spec_helper"

TAG_ATTRIBUTES = {
  id:           proc { be_a_nonempty(String) },
  raw:          proc { be_a_nonempty(String) },
  content:      proc { be_a_nonempty(String) },
  machine_tag?: proc { be_a_boolean }
}

describe Flickr::Tag, :vcr do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @tag = make_request("flickr.photos.getInfo").tags.first }
      subject { @tag }

      TAG_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end

    context "flickr.photos.search" do
      before(:all) { @tag = make_request("flickr.photos.search").find(PHOTO_ID).tags.first }
      subject { @tag }

      TAG_ATTRIBUTES.only(:content, :machine_tag?).each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
