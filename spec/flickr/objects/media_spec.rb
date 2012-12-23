require "spec_helper"

describe Flickr::Media do
  use_vcr_cassette

  before(:each) { @it = Flickr.media.find(PHOTO_ID).get_info! }

  describe "#short_url" do
    it "is valid" do
      @it.short_url.should be_an_existing_url
    end
  end
end
