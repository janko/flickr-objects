require "spec_helper"

describe Flickr::Configuration do
  it "provides configuration" do
    Flickr.configure do |config|
      config.api_key = "api_key"
      config.shared_secret = "shared_secret"

      config.access_token_key = "key"
      config.access_token_secret = "secret"

      config.open_timeout = 1
      config.timeout = 2

      config.use_ssl = true
      config.proxy = "proxy"

      config.pagination = :will_paginate
    end

    expect(Flickr.api_key).to eq "api_key"
    expect(Flickr.shared_secret).to eq "shared_secret"

    expect(Flickr.access_token).to eq ["key", "secret"]

    expect(Flickr.open_timeout).to eq 1
    expect(Flickr.timeout).to eq 2

    expect(Flickr.use_ssl).to eq true
    expect(Flickr.proxy).to eq "proxy"

    expect(Flickr.pagination).to eq :will_paginate
  end

  it "supports #secure=" do
    Flickr.configure do |config|
      config.use_ssl = false
      config.secure = true
    end

    expect(Flickr.use_ssl).to eq true
  end
end
