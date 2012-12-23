class Flickr
  class Error < StandardError
  end

  class OAuthError < Error
  end

  class ApiError < Error
    attr_reader :code

    def initialize(message, code = nil)
      super(message)
      @code = code.to_i
    end
  end

  class TimeoutError < Error
  end
end
