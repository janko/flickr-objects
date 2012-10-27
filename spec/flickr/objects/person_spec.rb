require "spec_helper"

PERSON_ATTRIBUTES = {
  id:          proc { be_a_nonempty(String) },
  nsid:        proc { be_a_nonempty(String) },
  username:    proc { be_a_nonempty(String) },
  real_name:   proc { be_a_nonempty(String) },
  location:    proc { be_a_nonempty(String) },
  icon_server: proc { be_a(Fixnum) },
  icon_farm:   proc { be_a(Fixnum) },
}

describe Flickr::Person do
  describe "methods" do
    before(:all) { @it = Flickr.media.find(PHOTO_ID).get_info!.owner }
    subject { @it }

    describe "#buddy_icon_url" do
      context "when person has an avatar" do
        its(:buddy_icon_url) { should be_an_existing_url }
      end

      context "when prerson doesn't have an avatar" do
        before(:each) { @it.stub(:icon_server).and_return(0) }

        its(:buddy_icon_url) { should be_an_existing_url }
      end
    end
  end

  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @media = Flickr.media.find(PHOTO_ID).get_info! }

      describe "photo's owner" do
        before(:each) { @it = @media.owner }
        subject { @it }

        PERSON_ATTRIBUTES.each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "notes' author" do
        before(:each) { @it = @media.notes.first.author }
        subject { @it }

        PERSON_ATTRIBUTES.only(:id, :nsid, :username).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "tags' author" do
        before(:each) { @it = @media.tags.first.author }
        subject { @it }

        PERSON_ATTRIBUTES.only(:id, :nsid).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end
    end

    context "flickr.photos.search" do
      before(:all) { @it = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID).owner }
      subject { @it }

      PERSON_ATTRIBUTES.except(:real_name, :location).each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
