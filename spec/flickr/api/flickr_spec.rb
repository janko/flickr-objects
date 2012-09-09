require "spec_helper"

describe Flickr, :vcr do
  describe ".test_login" do
    it "works" do
      person = Flickr.test_login
      person.username.should be_a_nonempty(String)
      person.id.should be_a_nonempty(String)
    end
  end

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
