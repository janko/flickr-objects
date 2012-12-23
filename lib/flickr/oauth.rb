require "faraday"
require "faraday_middleware"
require "flickr/middleware"

class Flickr
  module OAuth
    URL = "http://www.flickr.com/services/oauth".freeze
    NO_CALLBACK = 'oob'.freeze
    DEFAULTS = Client::DEFAULTS

    extend self

    def get_request_token(options = {})
      response = connection.get "request_token" do |req|
        req.params[:oauth_callback] = options[:callback_url] || NO_CALLBACK
      end

      RequestToken.new(response.body)
    end

    def get_access_token(verifier, request_token)
      response = connection(request_token.to_a).get "access_token" do |req|
        req.params[:oauth_verifier] = verifier
      end

      AccessToken.new(response.body)
    end

    class Token
      attr_reader :token, :secret

      def initialize(*args)
        if args.first.is_a?(Hash)
          @token = args.first[:oauth_token]
          @secret = args.first[:oauth_token_secret]
        else
          @token = args.first
          @secret = args.last
        end
      end

      def to_a
        [token, secret]
      end
    end

    class RequestToken < Token
      def authorize_url(params = {})
        require 'uri'
        url = URI.parse(URL)
        url.path += '/authorize'
        query_params = {oauth_token: token}.merge(params)
        url.query = query_params.map { |k,v| "#{k}=#{v}" }.join('&')
        url.to_s
      end

      def get_access_token(verifier)
        OAuth.get_access_token(verifier, self)
      end
    end

    class AccessToken < Token
      attr_reader :user_info

      def initialize(info)
        super
        @user_info = info.tap do |info|
          info.delete(:oauth_token)
          info.delete(:oauth_token_secret)
        end
      end
    end

    private

    def connection(request_token = nil)
      api_key, shared_secret = Flickr.configuration.fetch(:api_key, :shared_secret)

      open_timeout = Flickr.configuration.open_timeout || DEFAULTS[:open_timeout]
      timeout      = Flickr.configuration.timeout      || DEFAULTS[:timeout]

      url = URL
      proxy = Flickr.configuration.proxy

      params = {
        url: url,
        request: {
          open_timeout: open_timeout,
          timeout: timeout
        },
        proxy: proxy
      }

      Faraday.new(params) do |builder|
        builder.use Middleware::Retry
        builder.use FaradayMiddleware::OAuth,
         consumer_key: api_key,
         consumer_secret: shared_secret,
         token: Array(request_token).first,
         token_secret: Array(request_token).last

        builder.use Middleware::ParseOAuth
        builder.use Middleware::CheckOAuth

        builder.adapter :net_http
      end
    end
  end
end
