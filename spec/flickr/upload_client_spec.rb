require "spec_helper"

describe Flickr::UploadClient, :vcr do
  it "uploads photos and videos" do
    photo_id = Flickr.upload("#{RSPEC_DIR}/fixtures/files/photo.jpg")
    photo_id.should be_a_nonempty(String)

    video_id = Flickr.upload("#{RSPEC_DIR}/fixtures/files/video.mov")
    video_id.should be_a_nonempty(String)

    Flickr::Photo.find(photo_id).delete
    Flickr::Video.find(video_id).delete
  end

  it "raises an error if it can't find the content type" do
    expect { Flickr.upload("#{RSPEC_DIR}/fixtures/files/photo.janko") }.to raise_error(Flickr::Client::Error)
  end

  it "raises an appropriate Flickr error" do
    Flickr.configure { |config| config.api_key = nil }
    begin
      Flickr.upload("#{RSPEC_DIR}/fixtures/files/photo.jpg")
      (1 + 1).should eq(1)
    rescue Flickr::Client::Error => error
      error.message.should match(/Invalid API Key/)
      error.code.should eq(100)
    end
  end

  it "replaces" do
    begin
      Flickr.replace("#{RSPEC_DIR}/fixtures/files/photo.jpg", 1)
    rescue Flickr::Client::Error => error
      error.message.should match(/Not a pro account/)
    end
  end
end
