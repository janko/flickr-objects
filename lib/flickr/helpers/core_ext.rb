class Hash
  def slice(*keys)
    select { |key, value| keys.include?(key) }
  end unless method_defined?(:slice)
end
