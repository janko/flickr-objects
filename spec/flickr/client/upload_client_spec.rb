require "spec_helper"
require "rack/test"

describe Flickr::UploadClient, :vcr do
  before(:each) { @it = Flickr.upload_client }

  it "parses the response" do
    response = @it.upload file("photo.jpg")
    response.should be_a_nonempty(Hash)
    Flickr.photos.delete(response["photoid"])
  end

  describe "#upload" do
    it "passess the parameters" do
      response = @it.upload file("photo.jpg"), title: "Title"
      Flickr.photos.find(response["photoid"]).get_info!.title.should eq "Title"
      Flickr.photos.delete(response["photoid"])
    end

    it "uploads photos" do
      response = @it.upload file("photo.jpg")
      Flickr.photos.delete(response["photoid"])
    end

    it "uploads videos" do
      response = @it.upload file("video.mov")
      Flickr.videos.delete(response["photoid"])
    end

    it "uploads open files" do
      response = @it.upload File.open(file("photo.jpg"))
      Flickr.photos.delete(response["photoid"])
    end

    it "uploads Rails' files" do
      response = @it.upload Rack::Test::UploadedFile.new(file("photo.jpg"), "image/jpeg")
      Flickr.photos.delete(response["photoid"])
    end

    it "raises an error if it can't find the content type" do
      expect { @it.upload file("photo.janko") }.to raise_error(Flickr::Error)
    end
  end

  describe "#replace", :pro do
    it "parses the response" do
      response = @it.upload file("photo.jpg")
      response = @it.replace file("photo.jpg"), response["photoid"]
      response.should be_a_nonempty(Hash)
      Flickr.photos.delete(response["photoid"])
    end

    it "passes the parameters" do
      response = @it.upload file("photo.jpg")
      response = @it.replace file("photo.jpg"), response["photoid"], title: "Title"
      Flickr.photos.find(response["photoid"]).get_info!.title.should eq "Title"
      Flickr.photos.delete(response["photoid"])
    end
  end
end
