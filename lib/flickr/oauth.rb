require "uri"

module Flickr

  ##
  # Interface for authenticating through OAuth.
  #
  # Example:
  #
  #     request_token = Flickr::OAuth.get_request_token
  #     request_token.authorize_url
  #
  #     # ... user visits the authorize URL, and gets the verifier ...
  #
  #     access_token = request_token.get_access_token(verifier)
  #
  #     access_token.key       # "..."
  #     access_token.secret    # "..."
  #     access_token.user_info # {username: "...", nsid: "...", ...}
  #
  module OAuth

    extend self

    ##
    # @param params [Hash]
    # @option params [String] :callback_url If the user is being authorized
    #   through another web application, this parameter can be used to redirect
    #   the user back to that application.
    #
    # @return [Flickr::OAuth::RequestToken]
    #
    def get_request_token(params = {})
      params[:oauth_callback] = params.delete(:callback_url)
      response = client.get_request_token(params)
      RequestToken.new(response[:oauth_token], response[:oauth_token_secret])
    end

    ##
    # @param oauth_verifier [String] The code provided by Flickr after visiting
    #   the authorize URL.
    # @param request_token [RequestToken, Array(String, String)]
    #
    # @return [Flickr::OAuth::AccessToken]
    #
    def get_access_token(oauth_verifier, request_token)
      params = {oauth_verifier: oauth_verifier}
      response = client(request_token.to_a).get_access_token(params)
      AccessToken.new(response[:oauth_token], response[:oauth_token_secret],
        response.reject { |key, value| [:oauth_token, :oauth_token_secret].include?(key) })
    end

    class Token
      attr_reader :key, :secret
      alias token key

      ##
      # @param key [String]
      # @param secret [String]
      #
      def initialize(key, secret)
        @key, @secret = key, secret
      end

      def to_a
        [key, secret]
      end
    end

    class RequestToken < Token
      ##
      # @param params [Hash]
      # @option params [String] :perms Optional. Can be `read`, `write`, or `delete`,
      #   depending on which permissions you want (for example, "flickr.photos.delete"
      #   requires `delete` permissions). If not specified, defaults to `write`.
      #
      def authorize_url(params = {})
        url = URI.parse("http://www.flickr.com/services/oauth")
        url.path += "/authorize"
        query_params = {oauth_token: token}.merge(params)
        url.query = query_params.map { |k, v| "#{k}=#{v}" }.join("&")
        url.to_s
      end

      ##
      # @param oauth_verifier [String]
      # @see Flickr::OAuth.get_access_token.
      #
      def get_access_token(oauth_verifier)
        Flickr::OAuth.get_access_token(oauth_verifier, self)
      end
    end

    class AccessToken < Token
      ##
      # Holds user's information after authentication.
      #
      # @example
      #   {
      #     fullname:  "Janko Marohnić",
      #     user_nsid: "78733179@N04",
      #     username:  "@janko-m"
      #   }
      #
      attr_reader :user_info

      ##
      # @private
      #
      def initialize(key, secret, user_info)
        super(key, secret)
        @user_info = user_info
      end
    end

    private

    def client(request_token = nil)
      Flickr::Client::OAuth.new(request_token)
    end

  end

end
