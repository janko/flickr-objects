require "spec_helper"

describe "flickr.photosets.create" do
  use_vcr_cassette

  it "works" do
    set = Flickr.sets.create(title: "Title", primary_photo_id: MEDIA_ID)
    set.delete
  end
end
