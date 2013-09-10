require "spec_helper"
require "flickr/middleware"
require "flickr/sanitized_file"

describe Flickr::Middleware, :vcr do
  let(:client) do
    {
      data:   Flickr::Client::Data.new(Flickr.access_token),
      upload: Flickr::Client::Upload.new(Flickr.access_token),
      oauth:  Flickr::Client::OAuth.new,
    }
  end

  describe Flickr::Middleware::CatchTimeout do
    it "translates Faraday::Error::TimeoutError into Flickr::TimeoutError" do
      begin
        Flickr.configure { |config| config.timeout = 0 }
        client[:data].get "flickr.test.null"
      rescue => error
        unless error.is_a?(Faraday::Error::ConnectionFailed)
          expect(error).to be_a(Flickr::TimeoutError)
        end
      end
    end
  end

  describe Flickr::Middleware::CheckStatus do
    shared_examples "examples" do
      it "raises a Flickr::ApiError with proper error code and message" do
        Flickr.configure { |config| config.api_key = nil }

        begin
          make_request
        rescue => error
          expect(error).to be_a(Flickr::ApiError)
          expect(error.code).to eq 100
          expect(error.message).to eq "100: Invalid API Key (Key has invalid format)"
        end
      end
    end

    context "on data requests" do
      def make_request
        client[:data].get "flickr.test.null"
      end

      include_examples "examples"
    end

    context "on upload requests" do
      def make_request
        client[:upload].upload photo: Flickr::SanitizedFile.new(photo_path)
      end

      include_examples "examples"
    end
  end

  describe Flickr::Middleware::CheckOAuth do
    it "raises a Flickr::OAuthError" do
      Flickr.configure do |config|
        config.access_token_key = nil
        config.access_token_secret = nil
      end

      begin
        client[:data].get "flickr.test.login"
      rescue => error
        expect(error).to be_a(Flickr::OAuthError)
        expect(error.message).to eq "Parameter absent"
      end
    end
  end

  describe Flickr::Middleware::ParseOAuth do
    it "parses the OAuth response" do
      response = client[:oauth].get_request_token
      expect(response).to be_a(Hash)
      expect(response).not_to be_empty
    end
  end
end
