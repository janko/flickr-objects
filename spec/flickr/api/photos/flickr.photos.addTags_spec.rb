require "spec_helper"

describe "flickr.photos.addTags", :api_method do
  before(:each) {
    id = Flickr.upload file("photo.jpg")
    @photo = Flickr.photos.find(id)
  }

  it "works" do
    @photo.add_tags "Foo"
  end

  after(:each) { @photo.delete }
end
