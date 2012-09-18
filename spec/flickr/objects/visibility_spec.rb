require "spec_helper"

VISIBILITY_ATTRIBUTES = {
  public?:   proc { be_a_boolean },
  friends?:  proc { be_a_boolean },
  family?:   proc { be_a_boolean },
  contacts?: proc { be_a_boolean }
}

describe Flickr::Visibility do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @media = Flickr::Media.find(PHOTO_ID).get_info! }

      describe "visibility" do
        subject { @media.visibility }

        VISIBILITY_ATTRIBUTES.except(:contacts?).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "location_visibility" do
        subject { @media.location_visibility }

        VISIBILITY_ATTRIBUTES.each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end
    end

    context "flickr.photos.search" do
      before(:all) { @media = Flickr::Media.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID) }

      describe "visibility" do
        subject { @media.visibility }

        VISIBILITY_ATTRIBUTES.except(:contacts?).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "location_visibility" do
        subject { @media.location_visibility }

        VISIBILITY_ATTRIBUTES.each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end
    end
  end
end
