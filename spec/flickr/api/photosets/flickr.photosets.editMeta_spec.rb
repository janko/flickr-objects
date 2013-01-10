require "spec_helper"

describe "flickr.photosets.editMeta", :api_method do
  before(:each) { @set = Flickr.sets.find(SET_ID) }

  it "works" do
    @set.edit_meta(title: "Title")
  end
end
