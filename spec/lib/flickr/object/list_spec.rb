require "spec_helper"

describe Flickr::Object::List do
  let(:it)         { Flickr::Object::List.new(attributes).populate [photo] }
  let(:attributes) { {"page" => 1, "per_page" => 2, "total" => 3, "pages" => 2} }
  let(:photo)      { Flickr::Object::Photo.new("id" => "1") }
  record_api_methods

  def self.pagination(value)
    before { pagination!(value) }
    after  { pagination!(nil) }
  end

  def pagination!(value)
    Flickr.configure { |config| config.pagination = value }
    reload_list
  end

  def reload_list
    Flickr::Object.send(:remove_const, :List) if defined?(Flickr::Object::List)
    $LOADED_FEATURES.delete_if { |filename| filename =~ %r{flickr/object/.*list} }
    stub_const("Sinatra", Module.new) if Flickr.pagination == :kaminari
    require "flickr/object/list"
  end

  describe "#find" do
    context "when block is given" do
      it "does Enumerable#find" do
        expect(it.find { |photo| photo.id == "1" }).to eq photo
      end
    end

    context "when block is not given" do
      it "finds by ID" do
        expect(it.find("1")).to eq photo
      end

      it "finds by IDs" do
        expect(it.find(["1"])).to eq [photo]
      end
    end
  end

  describe "#find_by" do
    it "finds by attributes" do
      expect(it.find_by(id: "1")).to eq photo
    end

    it "accepts nested attributes" do
      it.first.update("owner" => {"username" => "janko"})
      expect(it.find_by(owner: {username: "janko"})).to eq photo
    end
  end

  describe "#find_by_<attribute>" do
    it "finds by attribute" do
      expect(it.find_by_id("1")).to eq photo
    end

    it "is deprecated" do
      expect(Flickr).to receive(:deprecation_warn)
      it.find_by_id("1")
    end
  end

  describe "#filter" do
    it "filters by attributes" do
      expect(it.filter(id: "1")).to eq [photo]
    end

    it "accepts nested attributes" do
      it.first.update("owner" => {"username" => "janko"})
      expect(it.filter(owner: {username: "janko"})).to eq [photo]
    end
  end

  context "when pagination is nil" do
    pagination nil

    it "assigns the pagination attributes correctly" do
      expect(it.current_page).to  eq attributes["page"]
      expect(it.per_page).to      eq attributes["per_page"]
      expect(it.total_entries).to eq attributes["total"]
      expect(it.total_pages).to   eq attributes["pages"]
    end

    it "assigns elements" do
      expect(it.count).to eq 1
    end

    context "without pagination attributes" do
      let(:attributes) { {} }

      it "doesn't raise errors" do
        expect(it[0]).to eq photo
      end
    end
  end

  context "when pagination is WillPaginate" do
    pagination :will_paginate

    it "assigns the attributes correctly" do
      expect(it.current_page).to  eq attributes["page"]
      expect(it.per_page).to      eq attributes["per_page"]
      expect(it.total_entries).to eq attributes["total"]
    end

    it "assigns elements" do
      expect(it.count).to eq 1
    end

    context "without pagination attributes" do
      let(:attributes) { {} }

      it "doesn't raise errors" do
        expect(it[0]).to eq photo
      end
    end
  end

  context "when pagination is Kaminari" do
    pagination :kaminari

    it "assigns the attributes correctly" do
      expect(it.offset_value).to eq attributes["page"]
      expect(it.limit_value).to  eq attributes["per_page"]
      expect(it.total_count).to  eq attributes["total"]
    end

    it "assigns elements" do
      expect(it.count).to eq 1
    end

    context "without pagination attributes" do
      let(:attributes) { {} }

      it "doesn't raise errors" do
        expect(it[0]).to eq photo
      end
    end
  end

  test_attributes do
    api_call "flickr.people.getPhotos",
             "flickr.people.getPhotosOf",
             "flickr.people.getPublicPhotos",
             "flickr.people.getContactsPublicPhotos",
             "flickr.photos.search",
             "flickr.photos.getContactsPhotos",
             "flickr.photos.getNotInSet",
             "flickr.photos.getRecent",
             "flickr.interestingness.getList",
             "flickr.photos.getUntagged",
             "flickr.photos.getWithGeoData",
             "flickr.photos.getWithoutGeoData",
             "flickr.photos.recentlyUpdated",
             "flickr.photos.getFavorites",
             "flickr.photosets.getPhotos" do
      object -> { self },
        %w[current_page per_page total_pages total_entries]
    end
  end
end
