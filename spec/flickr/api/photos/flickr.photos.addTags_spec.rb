require "spec_helper"

describe "flickr.photos.addTags" do
  use_vcr_cassette

  before(:each) {
    id = Flickr.upload file("photo.jpg")
    @media = Flickr.photos.find(id)
  }

  after(:each) { @media.delete }

  it "works" do
    @media.add_tags "Foo"
  end
end
