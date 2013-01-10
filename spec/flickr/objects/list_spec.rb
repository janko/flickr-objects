require "spec_helper"

describe Flickr::List do
  use_vcr_cassette

  let(:it) { Flickr.photos.search(user_id: PERSON_ID, page: 2, per_page: 1) }

  describe "#find" do
    it "finds by ID" do
      it.find(PHOTO_ID).should be_a(Flickr::Photo)
    end

    it "finds by IDs" do
      it.find([PHOTO_ID]).first.should be_a(Flickr::Photo)
    end

    it "allows Enumerable#find" do
      it.find { |photo| photo.id == PHOTO_ID }.should be_a(Flickr::Photo)
    end
  end

  it "has dynamic finders" do
    photo = it.find(PHOTO_ID)
    it.find_by_id(photo.id).should eq photo
    it.find_by_title(photo.title).should eq photo
  end

  describe "pagination" do
    def reload_list
      Flickr.send(:remove_const, "List")
      load "flickr/objects/list.rb"
      load "flickr/objects/attribute_values/list.rb"
    end

    context "when nil" do
      before(:each) {
        Flickr.configure { |config| config.pagination = nil }
        reload_list
      }

      it "assigns the attributes correctly" do
        it.current_page.should eq 2
        it.per_page.should eq 1
        it.total_entries.should eq 2
        it.total_pages.should eq 2
      end

      it "can loop through elements" do
        it.each { |photo| photo.is_a?(Flickr::Photo) }
      end
    end

    context "when will_paginate" do
      before(:each) {
        Flickr.configure { |config| config.pagination = :will_paginate }
        reload_list
      }

      it "assigns the attributes correctly" do
        it.current_page.should eq 2
        it.per_page.should eq 1
        it.total_entries.should eq 2
      end

      it "can loop through elements" do
        it.each { |photo| photo.is_a?(Flickr::Photo) }
      end
    end

    context "when kaminari" do
      before(:each) {
        stub_const("Sinatra", Module.new) # To not trigger Kaminari's warning messages
        Flickr.configure { |config| config.pagination = :kaminari }
        reload_list
      }

      it "assigns the attributes correctly" do
        it.offset_value.should eq 2
        it.limit_value.should eq 1
        it.total_count.should eq 2
      end

      it "can loop through elements" do
        it.each { |photo| photo.is_a?(Flickr::Photo) }
      end
    end

    context "when other" do
      before(:each) { Flickr.configure { |config| config.pagination = :other } }

      it "raises an error" do
        expect { reload_list }.to raise_error(Flickr::Error)
      end
    end

    after(:all) {
      Flickr.configure { |config| config.pagination = nil }
      Flickr.send(:remove_const, "List") if defined?(Flickr::List)
      load "flickr/objects/list.rb"
      load "flickr/objects/attribute_values/list.rb"
    }
  end
end
