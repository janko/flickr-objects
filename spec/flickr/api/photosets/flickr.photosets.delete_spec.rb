require "spec_helper"

describe "flickr.photosets.delete", :api_method do
  it "works" do
    set = Flickr.sets.create(title: "Title", primary_photo_id: PHOTO_ID)
    set.delete

    set = Flickr.sets.create(title: "Title", primary_photo_id: PHOTO_ID)
    Flickr.sets.delete(set.id)
  end
end
