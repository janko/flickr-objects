class Hash
  def except(*keys)
    reject { |key, value| keys.flatten.include?(key) }
  end
end
