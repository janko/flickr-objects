require "spec_helper"

describe "flickr.photos.delete", :api_method do
  it "works" do
    @id = Flickr.upload file("photo.jpg")
    Flickr.photos.find(@id).delete

    @id = Flickr.upload file("photo.jpg")
    Flickr.photos.delete(@id)
  end
end
