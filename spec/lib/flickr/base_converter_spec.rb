require "spec_helper"
require "flickr/base_converter"

describe Flickr::BaseConverter do
  let(:it) { described_class }

  describe "#to_base58" do
    it "converts a number to base 58" do
      expect(it.to_base58(57)).to eq "Z"
    end
  end
end
