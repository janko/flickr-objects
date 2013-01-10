require "spec_helper"

describe "flickr.photosets.addPhoto", :api_method do
  before(:each) {
    @id = Flickr.upload file("photo.jpg")
    @set = Flickr.sets.find(SET_ID)
  }

  it "works" do
    @set.add_photo(@id)
    @set.remove_photo(@id)
  end

  after(:each) {
    Flickr.photos.delete(@id)
  }
end
