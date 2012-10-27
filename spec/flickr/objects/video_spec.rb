require "spec_helper"
require "uri"

VIDEO_ATTRIBUTES = {
  ready?:   proc { be_a_boolean },
  failed?:  proc { be_a_boolean },
  pending?: proc { be_a_boolean },

  duration: proc { be_a(Integer) },
  width:    proc { be_a(Integer) },
  height:   proc { be_a(Integer) }
}

describe Flickr::Video do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @it = Flickr.videos.find(VIDEO_ID).get_info! }
      subject { @it }

      VIDEO_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end

  describe "methods" do
    context "flickr.photos.search" do
      before(:all) { @it = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(VIDEO_ID) }
      subject { @it }

      it "has #thumbnail" do
        @it.thumbnail("Square 75").should match URI.regexp
        @it.thumbnail("Square 75").should_not eq @it.thumbnail("Thumbnail")
      end
    end
  end
end
