require "spec_helper"

describe Flickr::Object, :vcr do
  describe "#==" do
    it "compares the IDs" do
      photo1 = Flickr.people.find(PERSON_ID).get_photos.find(PHOTO_ID)
      photo2 = Flickr.photos.find(PHOTO_ID).get_info!
      photo1.should eq photo2
    end

    it "falls back to regular #== when ID is not present" do
      photo = Flickr.photos.find(PHOTO_ID)
      photo.set_tags("Foo Bar")
      photo = Flickr.people.find(PERSON_ID).get_photos(extras: EXTRAS).find(PHOTO_ID)
      photo.tags.first.should_not eq photo.tags.last
    end

    it "falls back to reqular #== when the object doesn't repond to #id" do
      visibility = Flickr.photos.find(PHOTO_ID).get_info!.visibility
      visibility.should eq visibility
    end
  end

  describe "#find" do
    it "instantiates the object with an ID" do
      photo = Flickr.photos.find(11111)
      photo.should be_a(Flickr::Photo)
      photo.id.should eq "11111"
    end
  end

  it "doesn't raise errors on missing attributes" do
    photo = Flickr.photos.find(11111)
    expect { photo.title }.to_not raise_error
  end
end
