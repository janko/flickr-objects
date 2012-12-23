require "spec_helper"
require "uri"

describe Flickr::Photo do
  use_vcr_cassette

  before(:each) { @it = Flickr.photos.search(user_id: PERSON_ID, extras: EXTRAS).find(PHOTO_ID) }

  context "sizes" do
    it "recognizes different sizes" do
      @it.square75.size.should eq "Square 75"
      @it.square75.source_url.should_not eq @it.thumbnail.source_url
      @it.square75.width.should_not eq @it.thumbnail.width
      @it.square75.height.should_not eq @it.thumbnail.height
    end

    it "has dimensions" do
      @it.square(75).width.should eq 75
      @it.square(75).height.should eq 75
    end

    it "has the other naming style" do
      @it.square(75).size.should eq "Square 75"
    end

    it "has the bang versions" do
      @it.square75!
      @it.size.should eq "Square 75"
      @it.square150!
      @it.size.should eq "Square 150"

      @it.square!(75)
      @it.size.should eq "Square 75"
      @it.square!(150)
      @it.size.should eq "Square 150"
    end

    it "doesn't change size with the non-bang methods" do
      @it.large!(2048)
      @it.thumbnail
      @it.size.should eq "Large 2048"
    end

    it "can get the largest version" do
      @it.thumbnail!
      @it.largest.size.should eq "Large 2048"

      @it.thumbnail!
      @it.largest!
      @it.size.should eq "Large 2048"
    end

    it "has largest size" do
      @it.largest_size.should eq "Large 2048"
    end

    it "has available sizes" do
      @it.available_sizes.should eq Flickr::Photo::SIZES.keys.reject { |size| ["Original"].include?(size) }
    end

    context "smart" do
      describe "#size_or_smaller" do
        it "works" do
          @it.medium500_or_smaller.size.should eq "Medium 500"
          @it.original_or_smaller.size.should eq "Large 2048"
        end

        it "has the bang version" do
          @it.medium500_or_smaller!
          @it.size.should eq "Medium 500"
        end
      end

      describe "#size_at_least" do
        it "works" do
          @it.medium500_at_least.size.should eq "Large 2048"
          @it.original_at_least.size.should eq nil
        end

        it "has the bang version" do
          @it.medium500_at_least!
          @it.size.should eq "Large 2048"
        end
      end
    end

    context "flickr.photos.getSizes" do
      before(:each) { @it = Flickr.photos.find(PHOTO_ID).get_sizes! }

      it "has size attributes" do
        @it.square(75).source_url.should match URI.regexp
        @it.square(75).width.should be_a(Integer)
        @it.square(75).height.should be_a(Integer)
      end

      it "has all sizes" do
        Flickr::Photo::SIZES.keys.reverse.drop_while { |size| size != @it.largest_size }.each do |size|
          @it.send(size.downcase.delete(" ")).source_url.should be_a_nonempty(String)
        end
      end
    end
  end
end
