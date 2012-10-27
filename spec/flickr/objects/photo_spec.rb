require "spec_helper"

PHOTO_ATTRIBUTES = {
  rotation: proc { be_a(Integer) }
}

describe Flickr::Photo do
  describe "methods" do
    before(:all) { @it = Flickr.photos.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID) }
    subject { @it }

    it "recognizes different sizes" do
      @it.square75.size.should eq "Square 75"
      @it.square75.source_url.should_not eq @it.thumbnail.source_url
      @it.square75.width.should_not eq @it.thumbnail.width
      @it.square75.height.should_not eq @it.thumbnail.height
    end

    it "has a default size" do
      @it.size.should eq "Large 2048"
    end

    it "has the other naming style" do
      @it.square(75).size.should eq "Square 75"
    end

    it "has the bang versions" do
      @it.square75!
      @it.size.should eq "Square 75"
      @it.square150!
      @it.size.should eq "Square 150"

      @it.square!(75)
      @it.size.should eq "Square 75"
      @it.square!(150)
      @it.size.should eq "Square 150"
    end

    it "doesn't change size with the non-bang methods" do
      @it.large!(2048)
      @it.thumbnail
      @it.size.should eq "Large 2048"
    end

    it "can get the largest version" do
      @it.thumbnail!
      @it.largest.size.should eq "Large 2048"

      @it.thumbnail!
      @it.largest!
      @it.size.should eq "Large 2048"
    end
  end

  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @it = Flickr.photos.find(PHOTO_ID).get_info! }
      subject { @it }

      PHOTO_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
