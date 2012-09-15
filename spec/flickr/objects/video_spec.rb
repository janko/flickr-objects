require "spec_helper"

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
      before(:all) do
        VCR.use_cassette "flickr.photos.getInfo" do
          @video = Flickr::Video.find(VIDEO_ID).get_info!
        end
      end
      subject { @video }

      VIDEO_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
