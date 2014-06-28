require "spec_helper"

require "active_support/cache"

describe Flickr::Client, :vcr do
  before { Flickr.cache = cache }
  let(:cache) { ActiveSupport::Cache::MemoryStore.new(expires_in: 1.hour) }

  it "caches responses" do
    Flickr.test_echo
    expect_any_instance_of(Faraday::Adapter::NetHttp).not_to receive(:call)
    Flickr.test_echo
  end
end
