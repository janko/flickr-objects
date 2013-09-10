require "spec_helper"

describe Flickr::Object::Photo::Exif do
  let(:it) { described_class.new({}) }
  record_api_methods

  describe "#[]" do
    it "finds contents of items by label" do
      it.instance_variable_set("@attributes", [{"label" => "Label", "raw" => "Raw"}])
      expect(it["Label"]).to eq "Raw"
    end

    it "prefers clean over raw" do
      it.instance_variable_set("@attributes", [{"label" => "Label", "raw" => "Raw", "clean" => "Clean"}])
      expect(it["Label"]).to eq "Clean"
    end
  end
end

describe Flickr::Object::Photo::Exif::Item do
  let(:it) { described_class.new({}) }
  record_api_methods

  test_attributes do
    api_call "flickr.photos.getExif" do
      object -> { self.exif.items.find_by(label: "X-Resolution") },
        %w[tagspace tagspace_id tag label raw clean]
    end
  end
end
