require "spec_helper"

MEDIA_ATTRIBUTES = {
  id:                   proc { be_a_nonempty(String) },
  secret:               proc { be_a_nonempty(String) },
  server:               proc { be_a_nonempty(String) },
  farm:                 proc { be_a(Fixnum) },
  uploaded_at:          proc { be_a(Time) },
  favorite?:            proc { be_a_boolean },
  license:              proc { be_a(Fixnum) },
  safety_level:         proc { be_a(Fixnum) },
  title:                proc { be_a_nonempty(String) },
  description:          proc { be_a_nonempty(String) },
  posted_at:            proc { be_a(Time) },
  taken_at:             proc { be_a(Time) },
  taken_at_granularity: proc { be_a(Fixnum) },
  updated_at:           proc { be_a(Time) },
  views_count:          proc { be_a(Fixnum) },
  comments_count:       proc { be_a(Fixnum) },
  has_people?:          proc { be_a_boolean },
  path_alias:           proc { be_nil }
}

describe Flickr::Media, :vcr do
  describe "methods" do
    before(:all) { @media = make_request("flickr.photos.getInfo") }
    subject { @media }

    [:safe?, :moderate?, :restricted?].each do |safety_level|
      its(safety_level) { should be_a_boolean }
    end

    its(:url) { should be_a_nonempty(String) }
  end

  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @media = make_request("flickr.photos.getInfo") }
      subject { @media }

      MEDIA_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end

    context "flickr.photos.search" do
      before(:all) { @media = make_request("flickr.photos.search").find(PHOTO_ID) }
      subject { @media }

      MEDIA_ATTRIBUTES.except(:favorite?, :safety_level, :posted_at, :comments_count, :has_people?).each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
