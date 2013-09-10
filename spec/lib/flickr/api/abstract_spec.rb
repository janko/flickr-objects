require "spec_helper"

describe Flickr::Api::Abstract do
  before do
    @access_token = double(:access_token).as_null_object
    @it = Flickr::Api::Photo.new(@access_token)
  end

  describe "#find" do
    it "creates a new object with the given ID" do
      photo = @it.find("1")
      expect(photo.id).to eq "1"
    end

    it "passes along the access token" do
      photo = @it.find("1")
      expect(photo.access_token).to eq @access_token
    end
  end

  describe "#get" do
    it "makes an API call" do
      expect_any_instance_of(Flickr::Client::Data).to receive(:get)
      @it.send :get, "foo"
    end
  end

  describe "#post" do
    it "makes an API call" do
      expect_any_instance_of(Flickr::Client::Data).to receive(:post)
      @it.send :post, "foo"
    end
  end

  describe "#new_object" do
    it "instantiates a new object with given attributes" do
      photo = @it.send(:new_object, :Photo, {"id" => "1"})
      expect(photo.id).to eq "1"
    end

    it "passes along the access token" do
      photo = @it.send(:new_object, :Photo, {"id" => "1"})
      expect(photo.access_token).to eq @access_token
    end
  end

  describe "#new_list" do
    it "instantiates a new list of objects" do
      photos = @it.send(:new_list, :Photo, [{"id" => "1"}], {"page" => 1})
      expect(photos.current_page).to eq 1
      expect(photos.first.id).to eq "1"
    end

    it "passes the access token to those objects" do
      photos = @it.send(:new_list, :Photo, [{"id" => "1"}], {"page" => 1})
      expect(photos.first.access_token).to eq @access_token
    end
  end
end
