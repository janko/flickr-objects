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
    before(:all) { @person = Flickr.media.find(PHOTO_ID).get_info!.owner }

    describe "#buddy_icon_url" do
      context "when person has an avatar" do
        subject { @person }

        its(:buddy_icon_url) { should match(/#{@person.icon_server}/) }
      end

      context "when prerson doesn't have an avatar" do
        subject { @person.tap { |person| person.stub(:icon_server) { 0 } } }

        its(:buddy_icon_url) { should_not match(/\d/) }
      end
    end
  end

  describe "attributes" do
    context "flickr.test.login" do
      before(:all) { @person = Flickr.test_login }
      subject { @person }

      PERSON_ATTRIBUTES.only(:id, :nsid, :username).each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end

    context "flickr.photos.getInfo" do
      before(:all) { @media = Flickr.media.find(PHOTO_ID).get_info! }

      describe "photo's owner" do
        subject { @media.owner }

        PERSON_ATTRIBUTES.each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "notes' author" do
        subject { @media.notes.first.author }

        PERSON_ATTRIBUTES.only(:id, :nsid, :username).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end

      describe "tags' author" do
        subject { @media.tags.first.author }

        PERSON_ATTRIBUTES.only(:id, :nsid).each do |attribute, test|
          its(attribute) { should instance_eval(&test) }
        end
      end
    end

    context "flickr.photos.search" do
      before(:all) { @person = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID).owner }
      subject { @person }

      PERSON_ATTRIBUTES.except(:real_name, :location).each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
