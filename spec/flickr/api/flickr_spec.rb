require "spec_helper"

describe Flickr, :vcr do
  describe "flickr.test.echo" do
    before(:all) { @response = make_request("flickr.test.echo") }
    subject { @response }

    it { should be_a_nonempty(Hash) }
  end

  describe "flickr.test.null" do
    before(:all) { @response = make_request("flickr.test.null") }
    subject { @response }
  end
end
