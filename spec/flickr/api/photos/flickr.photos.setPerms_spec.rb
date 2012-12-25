require "spec_helper"

describe "flickr.photos.setPerms" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID)
  }

  it "works" do
    @photo.set_permissions(is_public: 1, is_friend: 0, is_family: 0, perm_comment: 3, perm_addmeta: 0)
  end
end
