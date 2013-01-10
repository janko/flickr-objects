require "spec_helper"

describe "flickr.photos.setMeta", :api_method do
  before(:each) { @photo = Flickr.photos.find(PHOTO_ID) }

  it "works" do
    @photo.set_meta(title: "Title", description: "Description")
  end
end
