require "spec_helper"

describe Flickr::Object::Photo do
  let(:it) { described_class.new({}, Flickr.access_token) }
  record_api_methods

  context "sizes" do
    before do
      described_class.any_instance.stub(:available_sizes) do
        ["Square 75", "Thumbnail", "Square 150", "Medium 500"]
      end
    end

    describe "#size!" do
      it "changes the size" do
        it.send(:size!, "Square 75")
        expect(it.size).to eq "Square 75"
      end

      it "only changes the size if available" do
        it.send(:size!, "Small 240")
        expect(it.size).to eq nil
      end

      it "raises an error if size doesn't exist" do
        expect { it.send(:size!, "Foobar") }.to raise_error
      end

      it "returns self" do
        expect(it.send(:size!, "Square 75")).to eq it
      end
    end

    describe "#<name><number>!" do
      it "changes the size" do
        expect(it).to receive(:size!).with("Square 75")
        it.square75!
      end

      it "works with no number" do
        expect(it).to receive(:size!).with("Thumbnail")
        it.thumbnail!
      end
    end

    describe "#<name><number>" do
      it "creates a new photo with the changed size" do
        expect(it.square75.size).to eq "Square 75"
        expect(it.size).to eq nil
      end
    end

    describe "#<name>!(<number>)" do
      it "changes the size" do
        [75, "75"].each do |number|
          expect(it).to receive(:size!).with("Square 75")
          it.square!(number)
        end
      end

      it "works with no number" do
        expect(it).to receive(:size!).with("Thumbnail")
        it.thumbnail!
      end
    end

    describe "#<name>(<number>)" do
      it "creates a new photo with the changed size" do
        expect(it.square(75).size).to eq "Square 75"
        expect(it.size).to eq nil
      end
    end

    describe "#largest!" do
      it "changes the size to largest available" do
        expect(it).to receive(:size!).with("Medium 500")
        it.largest!
      end
    end

    describe "#largest" do
      it "creates a new photos with the largest available size" do
        expect(it.largest.size).to eq "Medium 500"
        expect(it.size).to eq nil
      end
    end

    describe "#<size>_or_smaller!" do
      context "when <size> is available" do
        it "changes size to <size>" do
          expect(it).to receive(:size!).with("Square 150")
          it.square150_or_smaller!
        end
      end

      context "when <size> is not available" do
        it "changes size to next smaller than <size>" do
          expect(it).to receive(:size!).with("Square 150")
          it.small240_or_smaller!
        end
      end
    end

    describe "#<size>_or_smaller" do
      it "creates a new photo with the changed size" do
        expect(it.small240_or_smaller.size).to eq "Square 150"
        expect(it.size).to eq nil
      end
    end

    describe "#<size>_at_least!" do
      context "when <size> is the largest available" do
        it "changes size to <size>" do
          expect(it).to receive(:size!).with("Medium 500")
          it.medium500_at_least!
        end
      end

      context "when <size> is not the largest available" do
        it "changes size to largest available" do
          expect(it).to receive(:size!).with("Medium 500")
          it.square150_at_least!
        end
      end

      context "when <size> and larger ones don't exist" do
        it "changes size to nil" do
          expect(it).to receive(:size!).with(nil)
          it.medium640_at_least!
        end
      end
    end

    describe "#<size>_at_least" do
      it "creates a new photo with the changed size" do
        expect(it.square150_at_least.size).to eq "Medium 500"
        expect(it.size).to eq nil
      end
    end
  end

  describe "#get_info!" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:get_info).and_call_original
      it.get_info!
    end

    it "updates the photo with the reponse from the API call" do
      it.get_info!
      expect(it.title).to be_a(String)
    end
  end

  describe "#get_sizes!" do
    before { it.update("id" => "10115956703") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:get_sizes).and_call_original
      it.get_sizes!
    end

    it "updates the photo with the reponse from the API call" do
      it.get_sizes!
      expect(it.available_sizes).not_to be_empty
    end
  end

  describe "#get_exif!" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:get_exif).and_call_original
      it.get_exif!
    end

    it "updates the photo with the reponse from the API call" do
      it.get_exif!
      expect(it.exif.items).not_to be_empty
    end
  end

  describe "#get_favorites" do
    before { it.update("id" => "7316710626") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:get_favorites).and_call_original
      it.get_favorites
    end
  end

  describe "#delete" do
    before { it.update("id" => "10101061645") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:delete).and_call_original
      it.delete
    end
  end

  describe "#set_content_type" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:set_content_type).and_call_original
      it.set_content_type(1)
    end
  end

  describe "#set_tags" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:set_tags).and_call_original
      it.set_tags("foo")
    end
  end

  describe "#add_tags" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:add_tags).and_call_original
      it.add_tags("foo")
    end
  end

  describe "#remove_tag" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:remove_tag).and_call_original
      it.remove_tag("78701040-8130464513-14924")
    end
  end

  describe "#set_dates" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:set_dates).and_call_original
      it.set_dates(date_posted: Date.new(2013, 10, 5))
    end
  end

  describe "#set_meta" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:set_meta).and_call_original
      it.set_meta(title: "Photo")
    end
  end

  describe "#set_permissions" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:set_permissions).and_call_original
      it.set_permissions(is_public: 1, is_friend: 1, is_family: 1, perm_comment: 1, perm_addmeta: 1)
    end
  end

  describe "#set_safety_level" do
    before { it.update("id" => "8130464513") }

    it "makes the API call" do
      expect_any_instance_of(Flickr::Api::Photo).to receive(:set_safety_level).and_call_original
      it.set_safety_level(safety_level: 1)
    end
  end

  test_attributes do
    api_call "flickr.people.getPhotos",
             "flickr.people.getPhotosOf",
             "flickr.people.getPublicPhotos",
             "flickr.people.getContactsPublicPhotos",
             "flickr.photos.search",
             "flickr.photos.getContactsPhotos",
             "flickr.photos.getNotInSet",
             "flickr.photos.getUntagged",
             "flickr.photos.getWithGeoData",
             "flickr.photos.getWithoutGeoData",
             "flickr.photos.recentlyUpdated",
             "flickr.photosets.getPhotos" do
      object -> { self.find("10115956703") },
        %w[id secret server farm url uploaded_at license title
           description taken_at taken_at_granularity updated_at
           views_count path_alias available_sizes largest_size]
      object -> { self.find("10115956703").square75! },  %w[source_url width height]
      object -> { self.find("10115956703").square150! }, %w[source_url width height]
      object -> { self.find("10115956703").thumbnail! }, %w[source_url width height]
      object -> { self.find("10115956703").small240! },  %w[source_url width height]
      object -> { self.find("10115956703").small320! },  %w[source_url width height]
      object -> { self.find("10115956703").medium500! }, %w[source_url width height]
      object -> { self.find("10115956703").medium640! }, %w[source_url width height]
      object -> { self.find("10115956703").medium800! }, %w[source_url width height]
      object -> { self.find("10115956703").large1024! }, %w[source_url width height]
      object -> { self.find("10115956703").large1600! }, %w[source_url width height]
      object -> { self.find("10115956703").large2048! }, %w[source_url width height]
      object -> { self.find("10115956703").original! },  %w[source_url width height]
    end
    api_call "flickr.photos.getRecent" do
      object -> { self[0] },
        %w[id secret server farm url uploaded_at license title
           description taken_at taken_at_granularity updated_at
           views_count path_alias available_sizes largest_size]
    end
    api_call "flickr.photos.getInfo" do
      object -> { self },
        %w[id secret server farm url uploaded_at license title
           description taken_at taken_at_granularity updated_at
           views_count path_alias safety_level safe moderate
           restricted posted_at views_count comments_count
           has_people rotation]
    end
    api_call "flickr.photosets.getList" do
      object -> { self[0].primary_photo },
        %w[id]
    end
    api_call "flickr.photosets.getInfo" do
      object -> { self.primary_photo },
        %w[id]
    end
    api_call "flickr.photos.upload.checkTickets" do
      object -> { self[0].photo },
        %w[id]
    end
    api_call "flickr.photos.getSizes" do
      object -> { self },
        %w[available_sizes largest_size]
      object -> { self.square75! },  %w[source_url width height]
      object -> { self.square150! }, %w[source_url width height]
      object -> { self.thumbnail! }, %w[source_url width height]
      object -> { self.small240! },  %w[source_url width height]
      object -> { self.small320! },  %w[source_url width height]
      object -> { self.medium500! }, %w[source_url width height]
      object -> { self.medium640! }, %w[source_url width height]
      object -> { self.medium800! }, %w[source_url width height]
      object -> { self.large1024! }, %w[source_url width height]
      object -> { self.large1600! }, %w[source_url width height]
      object -> { self.large2048! }, %w[source_url width height]
      object -> { self.original! },  %w[source_url width height]
    end
  end
end
