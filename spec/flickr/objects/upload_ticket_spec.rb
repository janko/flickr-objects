require "spec_helper"

UPLOAD_TICKET_ATTRIBUTES = {
  id:        proc { be_a_nonempty(String) },
  status:    proc { be_a(Integer) },
  invalid?:  proc { be_a_boolean },
  complete?: proc { be_a_boolean },
  failed?:   proc { be_a_boolean },
  media:     proc { be_a(Flickr::Media) },
  photo:     proc { be_a(Flickr::Photo) },
  video:     proc { be_a(Flickr::Video) },
}

describe Flickr::UploadTicket do
  describe "attributes and methods" do
    it "works" do
      pending "Figure out a way how to change VCR cassettes"
    end
  end
end
