require "spec_helper"

describe "flickr.photos.addTags" do
  use_vcr_cassette

  before(:each) {
    id = Flickr.upload file("photo.jpg")
    @photo = Flickr.photos.find(id)
  }

  after(:each) { @photo.delete }

  it "works" do
    @photo.add_tags "Foo"
  end
end
