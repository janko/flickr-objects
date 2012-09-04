require "spec_helper"
require "set"

describe Flickr::ApiMethods do
  it "works" do
    Set.new(Flickr.api_methods["flickr.photos.search"]).should ==
      Set.new(["Flickr::Media.search", "Flickr::Photo.search", "Flickr::Video.search"])
    Set.new(Flickr.api_methods["flickr.photos.getInfo"]).should ==
      Set.new(["Flickr::Media#get_info!", "Flickr::Photo#get_info!", "Flickr::Video#get_info!"])
  end
end
