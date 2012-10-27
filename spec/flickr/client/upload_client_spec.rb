require "spec_helper"

describe Flickr::UploadClient do
  before(:each) { @it = Flickr.upload_client }

  it "uploads photos" do
    response = @it.upload("#{RSPEC_DIR}/fixtures/files/photo.jpg")
    Flickr::Photo.find(response["photoid"]).delete
  end

  it "uploads videos" do
    response = @it.upload("#{RSPEC_DIR}/fixtures/files/video.mov")
    Flickr::Video.find(response["photoid"]).delete
  end

  it "raises an error if it can't find the content type" do
    expect { @it.upload("#{RSPEC_DIR}/fixtures/files/photo.janko") }.to raise_error(Flickr::Client::Error)
  end

  # With pro account
  it "replaces" do
  end
end
