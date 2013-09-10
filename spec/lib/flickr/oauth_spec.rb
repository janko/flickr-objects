require "spec_helper"
require "capybara"
require "uri"
require "cgi"

describe Flickr::OAuth do
  let(:it) { described_class }

  before { Capybara.current_driver = :selenium }
  after { Capybara.current_session.reset! }

  include Capybara::DSL

  def login
    fill_in "username", with: SETTINGS.fetch(:yahoo_email)
    fill_in "passwd",   with: SETTINGS.fetch(:yahoo_password)
    click_on "Sign In"
  end

  describe ".get_request_token" do
    it "fetches the request token", :vcr do
      request_token = it.get_request_token

      expect(request_token.key).to be_a_nonempty(String)
      expect(request_token.secret).to be_a_nonempty(String)
    end

    it "passes through the :callback_url option" do
      expect_any_instance_of(Flickr::Client::OAuth).to receive(:get_request_token).with(oauth_callback: "http://google.com") { double.as_null_object }
      it.get_request_token(callback_url: "http://google.com")
    end
  end

  describe ".get_access_token" do
    it "fetches the access token", slow: true do
      request_token = it.get_request_token

      visit request_token.authorize_url(perms: "delete")
      login if page.has_field?("username")
      click_on "OK, I'LL AUTHORIZE IT"

      oauth_verifier = all("#Main p").last.text
      access_token = it.get_access_token(oauth_verifier, request_token)

      expect(access_token.key).to be_a_nonempty(String)
      expect(access_token.secret).to be_a_nonempty(String)
      expect(access_token.user_info).to be_a_nonempty(Hash)
    end

    it "accepts `request_token` as a RequestToken or an Array" do
      request_token = Flickr::OAuth::RequestToken.new("key", "secret")
      Flickr::Client::OAuth.any_instance.stub(:get_access_token) { double.as_null_object }
      it.get_access_token("oauth_verifier", request_token)

      request_token = ["key", "secret"]
      Flickr::Client::OAuth.any_instance.stub(:get_access_token) { double.as_null_object }
      it.get_access_token("oauth_verifier", request_token)
    end
  end
end

describe Flickr::OAuth::Token do
  let(:it) { described_class.new("key", "secret") }

  it "aliases #key to #token" do
    expect(it.token).to eq it.key
  end
end

describe Flickr::OAuth::RequestToken do
  let(:it) { described_class.new("key", "secret") }

  describe "#authorize_url" do
    it "passes through additional parameters" do
      url = it.authorize_url(perms: "read")
      params = parse_query(url)
      expect(params["perms"]).to eq "read"
    end
  end

  describe "#get_access_token" do
    it "delegates to Flickr::OAuth" do
      expect(Flickr::OAuth).to receive(:get_access_token).with("oauth_verifier", it)
      it.get_access_token("oauth_verifier")
    end
  end
end
