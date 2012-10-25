class Flickr
  module Base58
    ALPHABET = '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ'.chars.to_a.freeze

    def to_base58(value)
      value = Integer(value)
      begin
        value, remainder = value.divmod(58)
        result = ALPHABET[remainder] + (result || '')
      end while value > 0

      result
    end
  end
end
