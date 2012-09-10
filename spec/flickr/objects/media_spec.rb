require "spec_helper"

MEDIA = {
  id:                   proc { be_a_nonempty(String) },
  secret:               proc { be_a_nonempty(String) },
  server:               proc { be_a_nonempty(String) },
  farm:                 proc { be_a(Fixnum) },
  uploaded_at:          proc { be_a(Time) },
  favorite?:            proc { be_a_boolean },
  license:              proc { be_a(Fixnum) },
  safety_level:         proc { be_a(Fixnum) },
  title:                proc { be_a_nonempty(String) },
  description:          proc { be_an_empty(String) },
  posted_at:            proc { be_a(Time) },
  taken_at:             proc { be_a(Time) },
  taken_at_granularity: proc { be_a(Fixnum) },
  updated_at:           proc { be_a(Time) },
  views_count:          proc { be_a(Fixnum) },
  comments_count:       proc { be_a(Fixnum) },
  has_people?:          proc { be_a_boolean }
}

describe Flickr::Media, :vcr do
  context "flickr.photos.getInfo" do
    it "has correct attributes" do
      media = Flickr::Media.find(PHOTO_ID)
      media.get_info!

      MEDIA.each do |attribute, test|
        media.send(attribute).should instance_eval(&test)
      end
    end
  end
end
