require "spec_helper"

SET_ATTRIBUTES = {
  id:  proc { be_a_nonempty(String) },
  url: proc { be_a_nonempty(String) },
}

describe Flickr::Set do
  describe "attributes" do
    context "flickr.photosets.create and flickr.photosets.delete" do
      before(:each) { @it = Flickr.sets.create(title: "Title", primary_photo_id: PHOTO_ID) }
      subject { @it }

      SET_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end

      after(:each) { @it.delete }
    end
  end
end
