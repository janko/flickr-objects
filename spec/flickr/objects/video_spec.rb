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
      before(:all) { @video = Flickr.videos.find(VIDEO_ID).get_info! }
      subject { @video }

      VIDEO_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end

  describe "methods" do
    context "flickr.photos.search" do
      before(:all) { @video = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(VIDEO_ID) }
      subject { @video }

      it "has #thumbnail" do
        @video.thumbnail("Square 75").should match(URI.regexp)
        @video.thumbnail("Square 75").should_not eq(@video.thumbnail("Thumbnail"))
      end
    end
  end
end
