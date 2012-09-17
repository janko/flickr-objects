require "spec_helper"

describe Flickr::MethodsClient do
  describe "#include_in_extras" do
    it "works" do
      hash = {}
      Flickr.client.send(:include_in_extras, hash, "foo")
      hash.should eq({extras: "foo"})
      Flickr.client.send(:include_in_extras, hash, "bar")
      hash.should eq({extras: "foo,bar"})
    end
  end
end
