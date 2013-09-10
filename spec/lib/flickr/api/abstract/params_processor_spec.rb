require "spec_helper"

describe Flickr::Api::Abstract::ParamsProcessor do
  describe "#process_for" do
    it "adds sizes on specific flickr methods" do
      processor = described_class.new(sizes: ["Thumbnail"])
      params = processor.process_for("photos.search")
      expect(params[:extras]).to eq "url_t"

      processor = described_class.new(sizes: ["Thumbnail"])
      params = processor.process_for("foo.bar")
      expect(params[:extras]).to eq nil
    end
  end

  describe "#add_sizes!" do
    it "adds all sizes on :sizes => :all or :sizes => true" do
      [:all, true].each do |value|
        processor = described_class.new(sizes: value)
        processor.send(:add_sizes!)
        expect(processor.params[:extras]).to eq "url_sq,url_t,url_q,url_s,url_n,url_m,url_z,url_c,url_l,url_h,url_k,url_o"
      end
    end

    it "adds specific sizes on :sizes => [...]" do
      processor = described_class.new(sizes: ["Square 75", "Thumbnail"])
      processor.send(:add_sizes!)
      expect(processor.params[:extras]).to eq "url_sq,url_t"
    end

    it "appends to existing extras" do
      processor = described_class.new(sizes: ["Square 75", "Thumbnail"], extras: "foo,bar")
      processor.send(:add_sizes!)
      expect(processor.params[:extras]).to eq "foo,bar,url_sq,url_t"
    end
  end
end
