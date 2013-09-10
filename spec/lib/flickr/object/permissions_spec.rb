require "spec_helper"

describe Flickr::Object::Permissions do
  let(:it) { described_class.new({}) }
  record_api_methods

  test_attributes do
    api_call "flickr.photos.getInfo" do
      object -> { self.editability },
        %w[can_comment can_add_meta]
      object -> { self.public_editability },
        %w[can_comment can_add_meta]
      object -> { self.usage },
        %w[can_download can_blog can_print can_share]
    end
    api_call "flickr.photosets.getList" do
      object -> { self[0].permissions },
        %w[can_comment]
    end
    api_call "flickr.photosets.getInfo" do
      object -> { self.permissions },
        %w[can_comment]
    end
  end
end
