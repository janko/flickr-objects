require "spec_helper"

describe Flickr::Object::Person::UploadStatus do
  let(:it) { described_class.new({}) }
  record_api_methods

  test_attributes do
    api_call "flickr.people.getUploadStatus" do
      object -> { self },
        %w[maximum_photo_size]
    end
  end
end

describe Flickr::Object::Person::UploadStatus::Month do
  let(:it) { described_class.new({}) }
  record_api_methods

  test_attributes do
    api_call "flickr.people.getUploadStatus" do
      object -> { self.current_month },
        %w[maximum used remaining]
    end
  end
end
