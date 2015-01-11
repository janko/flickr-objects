require "spec_helper"

describe Flickr::Api::License do
  let(:it) { described_class.new(Flickr.access_token) }
  record_api_methods

  describe "#all" do
    it "returns a list of licenses" do
      licenses = it.all
      expect(licenses).to be_a_list_of(Flickr::Object::License)
    end
  end
end
