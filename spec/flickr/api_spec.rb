require "spec_helper"

# Here are tests for all the methods that don't return a
# Flickr::Object instance.

describe "API", :vcr do
  describe "Flickr.test_echo" do
    it "works" do
      hash = Flickr.test_echo
      hash.should be_a_nonempty(Hash)
    end
  end

  describe "Flickr.test_null" do
    it "works" do
      Flickr.test_null
    end
  end

  describe "Flickr::Media#set_content_type" do
    it "works" do
      media = Flickr::Media.find(PHOTO_ID)
      media.client.should_receive(:post).with({photo_id: PHOTO_ID, content_type: 1})
      media.set_content_type(1)
    end

    it "has the cool alias" do
      media = Flickr::Media.find(PHOTO_ID)
      media.client.should_receive(:post).with({photo_id: PHOTO_ID, content_type: 1})
      media.content_type = 1
    end
  end
end
