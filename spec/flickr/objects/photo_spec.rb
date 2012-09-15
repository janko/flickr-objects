require "spec_helper"

PHOTO_ATTRIBUTES = {
  rotation: proc { be_a(Integer) }
}

describe Flickr::Photo, :vcr do
  describe "methods" do
    before(:all) do
      VCR.use_cassette "flickr.photos.search" do
        @photo = Flickr::Photo.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID)
      end
    end
    subject { @photo }

    it "recognizes different sizes" do
      @photo.square75.size.should eq("Square 75")
      @photo.square75.source_url.should_not eq(@photo.thumbnail.source_url)
      @photo.square75.width.should_not eq(@photo.thumbnail.width)
      @photo.square75.height.should_not eq(@photo.thumbnail.height)
    end

    it "has a default size" do
      @photo.size.should eq("Large 2048")
    end

    it "has the other naming style" do
      @photo.square(75).size.should eq("Square 75")
    end

    it "has the bang versions" do
      @photo.square75!
      @photo.size.should eq("Square 75")
      @photo.square150!
      @photo.size.should eq("Square 150")

      @photo.square!(75)
      @photo.size.should eq("Square 75")
      @photo.square!(150)
      @photo.size.should eq("Square 150")
    end

    it "doesn't change size with the non-bang methods" do
      @photo.large!(2048)
      @photo.thumbnail
      @photo.size.should eq("Large 2048")
    end

    it "can get the largest version" do
      @photo.thumbnail!
      @photo.largest.size.should eq("Large 2048")

      @photo.thumbnail!
      @photo.largest!
      @photo.size.should eq("Large 2048")
    end
  end

  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @photo = make_request("flickr.photos.getInfo", Flickr::Photo) }
      subject { @photo }

      PHOTO_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
