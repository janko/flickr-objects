require "spec_helper"

PERSON = {
  id:          proc { be_a_nonempty(String) },
  nsid:        proc { be_a_nonempty(String) },
  username:    proc { be_a_nonempty(String) },
  real_name:   proc { be_an_empty(String) },
  location:    proc { be_an_empty(String) },
  icon_server: proc { be_a(Fixnum) },
  icon_farm:   proc { be_a(Fixnum) },
}

describe Flickr::Person, :vcr do
  context "flickr.test.login" do
    let(:person) { Flickr.test_login }

    it "works" do
      PERSON.slice(:id, :nsid, :username).each do |attribute, test|
        person.send(attribute).should instance_eval(&test)
      end
    end
  end

  context "flickr.photos.getInfo" do
    let(:media) { Flickr::Media.find(PHOTO_ID).get_info! }

    it "has correct attributes" do
      PERSON.each do |attribute, test|
        media.owner.send(attribute).should instance_eval(&test)
      end

      PERSON.slice(:id, :nsid, :username).each do |attribute, test|
        media.notes.first.author.send(attribute).should instance_eval(&test)
      end

      PERSON.slice(:id, :nsid).each do |attribute, test|
        media.tags.first.author.send(attribute).should instance_eval(&test)
      end
    end
  end

  context "flickr.test.login" do
    let(:person) { Flickr.test_login }

    it "has correct attributes" do
      PERSON.slice(:id, :nsid, :username).each do |attribute, test|
        person.send(attribute).should instance_eval(&test)
      end
    end
  end
end
