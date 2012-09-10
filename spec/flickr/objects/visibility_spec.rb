require "spec_helper"

describe Flickr::Visibility, :vcr do
  context "flickr.photos.getInfo" do
    it "has correct attributes" do
      media = Flickr::Media.find(PHOTO_ID)
      media.get_info!

      [:can_comment?, :can_add_meta?].each do |attribute|
        media.editability.send(attribute).should be_a_boolean
        media.public_editability.send(attribute).should be_a_boolean
      end

      [:can_download?, :can_blog?, :can_print?, :can_share?].each do |attribute|
        media.usage.send(attribute).should be_a_boolean
      end
    end
  end
end
