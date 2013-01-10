shared_examples "list" do
  context Flickr::List do
    it "has correct attributes" do
      test_attributes(@response, ATTRIBUTES[:list])
    end
  end
end

shared_examples "extras" do
  describe Flickr::Photo do
    it "has sizes" do
      @photo.available_sizes.should include("Thumbnail")
    end

    it "has the expected extras attributes" do
      keys = @photo.instance_variable_get("@hash").keys.
        reject { |key| key =~ /^(url|width|height)_\w+$/ }

      (keys - EXTRAS_KEYS).should eq []
    end
  end
end

EXTRAS_KEYS = ["id", "owner", "secret", "server", "farm", "title", "username", "ispublic", "isfriend", "isfamily", "isprimary"]
