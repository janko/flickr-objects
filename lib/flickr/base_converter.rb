module Flickr

  ##
  # Converts numbers to different bases, used for generating URLs in Flickr. For example,
  # base 58 is used for generating short URLs.
  #
  # @private
  #
  module BaseConverter

    extend self

    BASE58_ALPHABET = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".chars.to_a.freeze

    def to_base58(number)
      number = Integer(number)
      result = ""

      begin
        number, remainder = number.divmod(58)
        result = BASE58_ALPHABET[remainder] + result
      end while number > 0

      result
    end

  end

end
