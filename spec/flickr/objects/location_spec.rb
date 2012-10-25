require "spec_helper"

LOCATION_ATTRIBUTES = {
  latitude:  proc { be_a(Float) },
  longitude: proc { be_a(Float) },
  accuracy:  proc { be_a(Integer) },
  context:   proc { be_a(Integer) },
  place_id:  proc { be_a_nonempty(String) },
  woe_id:    proc { be_a_nonempty(String) }
}

AREA_ATTRIBUTES = {
  name:     proc { be_a_nonempty(String) },
  place_id: proc { be_a_nonempty(String) },
  woe_id:   proc { be_a_nonempty(String) }
}

describe Flickr::Location do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @location = Flickr.media.find(PHOTO_ID).get_info!.location }
      subject { @location }

      LOCATION_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end

      describe Flickr::Location::Area do
        [:neighbourhood, :locality, :county, :region, :country].each do |area|
          subject { @location.send(area) }

          AREA_ATTRIBUTES.each do |attribute, test|
            its(attribute) { should instance_eval(&test) }
          end
        end
      end
    end

    context "flickr.photos.search" do
      before(:all) { @location = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(PHOTO_ID).location }
      subject { @location }

      LOCATION_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end
end
