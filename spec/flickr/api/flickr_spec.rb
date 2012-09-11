require "spec_helper"

describe Flickr, :vcr do
  describe ".test_echo" do
    it "works" do
      hash = Flickr.test_echo
      hash.should be_a_nonempty(Hash)
    end
  end

  describe ".test_null" do
    it "works" do
      Flickr.test_null
    end
  end
end
