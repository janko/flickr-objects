require "spec_helper"

describe "replace", :vcr, :pro do
  context "synchronous" do
    before(:each) {
      id = Flickr.upload file("photo.jpg")
      @response = Flickr.replace file("photo.jpg"), id
    }

    it "returns a valid media ID" do
      expect {
        Flickr.photos.find(@response).get_info!
      }.to_not raise_error
    end

    after(:each) { Flickr.photos.delete(@response) }
  end

  context "asynchronous" do
    before(:each) {
      id = Flickr.upload file("photo.jpg")
      @response = Flickr.replace file("photo.jpg"), id, async: 1
    }

    it "returns a valid ticket ID" do
      ticket = Flickr.upload_tickets.check(@response).find(@response)
      ticket.should_not be_invalid
    end

    after(:each) {
      # sleep 3
      Flickr.check_upload_tickets(@response).find(@response).photo.delete
    }
  end
end
