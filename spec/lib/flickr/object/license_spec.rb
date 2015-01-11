require "spec_helper"

describe Flickr::Object::License do
  record_api_methods

  test_attributes do
    api_call "flickr.photos.licenses.getInfo" do
      object -> { self.last }, %w[id name url]
    end
  end
end
