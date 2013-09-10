require "spec_helper"

describe Flickr::Object::Photo::Note do
  let(:it) { described_class.new({}) }
  record_api_methods

  test_attributes do
    api_call "flickr.photos.getInfo" do
      object -> { self.notes[0] },
        %w[id coordinates width height content]
    end
  end
end
