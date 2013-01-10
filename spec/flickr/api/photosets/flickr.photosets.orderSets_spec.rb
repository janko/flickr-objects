require "spec_helper"

describe "flickr.photosets.orderSets", :api_method do
  it "works" do
    Flickr.sets.order(SET_ID)
  end
end
