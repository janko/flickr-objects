class Flickr
  class ApiMethods < Hash
    def add(api_method, method)
      store(api_method, (Array(values_at(api_method).compact).flatten + [method]))
    end
  end
end
