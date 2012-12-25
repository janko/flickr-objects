require "spec_helper"

describe "flickr.photosets.orderSets" do
  use_vcr_cassette

  it "works" do
    Flickr.sets.order(SET_ID)
  end
end
