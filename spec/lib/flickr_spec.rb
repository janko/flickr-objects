require "spec_helper"

describe Flickr do
  let(:it) { described_class }

  describe ".new" do
    it "creates an instance with different access token" do
      flickr = it.new("foo", "bar")
      expect(flickr.access_token).to eq ["foo", "bar"]
    end

    it "doesn't change the global access token" do
      expect { it.new("foo", "bar") }.not_to change { Flickr.access_token }
    end

    it "gives the instance the same configuration" do
      flickr = it.new("foo", "bar")
      expect(flickr.api_key).to eq Flickr.api_key
    end
  end
end
