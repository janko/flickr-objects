require "spec_helper"

describe "flickr.photos.delete" do
  use_vcr_cassette

  it "works" do
    @id = Flickr.upload file("photo.jpg")
    Flickr.photos.find(@id).delete

    @id = Flickr.upload file("photo.jpg")
    Flickr.photos.delete(@id)
  end
end
