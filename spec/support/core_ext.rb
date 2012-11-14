class Hash
  def except(*keys)
    reject { |key, value| keys.flatten.include?(key) }
  end

  alias only slice

  def symbolize_keys!
    keys.each do |key|
      self[key.to_sym] = delete(key)
    end
    self
  end

  def symbolize_keys
    dup.symbolize_keys!
  end
end
