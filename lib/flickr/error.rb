module Flickr

  class Error < StandardError
  end

  ##
  # This error is raised when there is an OAuth error (for example when the
  # access token is missing on requests which require authentication).
  #
  class OAuthError < Error
  end

  ##
  # This error is raised when there is an error in the request.
  #
  # @see #code
  #
  class ApiError < Error
    ##
    # Flickr's code of the error. The list possible errors and their codes is
    # shown below every API method on {http://flickr.com/services/api}.
    # For example:
    #
    #   - 100: There is no API key
    #   - 105: Service currently unavailable
    #   - ...
    #
    # @example
    #   begin
    #     Flickr.photos.get_recent
    #   rescue Flickr::ApiError => error
    #     puts "There is no API key" if error.code == 100
    #   end
    # @return [Integer]
    #
    attr_reader :code

    ##
    # @private
    #
    def initialize(message, code = nil)
      super(message)
      @code = code.to_i
    end

    def message
      "#{code}: #{super}"
    end
  end

  ##
  # @see Flickr::Configuration#open_timeout
  # @see Flickr::Configuration#timeout
  #
  class TimeoutError < Error
  end

end
