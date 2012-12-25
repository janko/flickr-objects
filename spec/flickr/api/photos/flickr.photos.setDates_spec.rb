require "spec_helper"

describe "flickr.photos.setDates" do
  use_vcr_cassette

  before(:each) {
    @photo = Flickr.photos.find(PHOTO_ID)
  }

  it "works" do
    @photo.set_dates(date_taken_granularity: 0)
  end
end
