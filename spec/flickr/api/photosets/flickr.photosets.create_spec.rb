require "spec_helper"

describe "flickr.photosets.create", :api_method do
  it "works" do
    set = Flickr.sets.create(title: "Title", primary_photo_id: PHOTO_ID)
    set.delete
  end
end
