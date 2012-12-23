require "spec_helper"

describe "flickr.photosets.addPhoto" do
  use_vcr_cassette

  before(:each) {
    @id = Flickr.upload file("photo.jpg")
    @set = Flickr.sets.find(SET_ID)
  }

  after(:each) {
    Flickr.photos.delete(@id)
  }

  it "works" do
    @set.add_photo(@id)
    @set.remove_photo(@id)

    @set.add_video(@id)
    @set.remove_video(@id)

    @set.add_media(@id)
    @set.remove_media(@id)
  end
end
