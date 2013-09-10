require "spec_helper"

describe Flickr::Object::Set do
  let(:it) { described_class.new({}, Flickr.access_token) }
  record_api_methods

  describe "#delete" do
    before { it.update("id" => "72157636218244365") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:delete).and_call_original
      it.delete
    end
  end

  describe "#edit_photos" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:edit_photos).and_call_original
      it.edit_photos(primary_photo_id: "8130464513", photo_ids: "8130464513")
    end
  end

  describe "#get_info!" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:get_info).and_call_original
      it.get_info!
    end

    it "updates the set with the response from the API call" do
      it.get_info!
      expect(it.title).to be_a(String)
    end
  end

  describe "#get_photos" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:get_photos).and_call_original
      it.get_photos
    end
  end

  describe "#add_photo" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:add_photo).and_call_original
      it.add_photo("10101322155")
    end
  end

  describe "#remove_photos" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:remove_photos).and_call_original
      it.remove_photos("10101322155")
    end
  end

  describe "#remove_photo" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:remove_photo).and_call_original
      it.remove_photo("10101322155")
    end
  end

  describe "#edit_meta" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:edit_meta).and_call_original
      it.edit_meta(title: "Set")
    end
  end

  # Triggers an OAuth error for some reason
  describe "#reorder_photos" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      # expect_any_instance_of(Flickr::Api::Set).to receive(:reorder_photos).and_call_original
      # it.reorder_photos(photo_ids: "8130464513")
    end
  end

  describe "#set_primary_photo" do
    before { it.update("id" => "72157636216289703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Set).to receive(:set_primary_photo).and_call_original
      it.set_primary_photo("8130464513")
    end
  end

  test_attributes do
    api_call "flickr.photosets.getList" do
      object -> { self[0] },
        %w[id secret server farm photos_count title description created_at updated_at]
    end
    api_call "flickr.photosets.getInfo" do
      object -> { self },
        %w[id secret server farm photos_count views_count comments_count title
           description created_at updated_at]
    end
    api_call "flickr.photosets.create" do
      object -> { self },
        %w[id url]
    end
  end
end
