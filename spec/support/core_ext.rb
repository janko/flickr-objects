class Hash
  def only(*keys)
    select { |key, value| keys.flatten.include?(key) }
  end
end
