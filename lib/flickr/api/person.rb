class Flickr
  class Person < Object
    def self.find_by_email(email, params = {})
      response = client.get f(__method__), params.merge(find_email: email)
      new(response["user"], client)
    end

    def self.find_by_username(username, params = {})
      response = client.get f(__method__), params.merge(username: username)
      new(response["user"], client)
    end

    def get_info!(params = {})
      response = client.get f(__method__), params.merge(user_id: id)
      @hash.update(response["person"])
      self
    end

    def get_photos(params = {})
      response = client.get f(__method__), handle_extras(params.merge(user_id: id))
      Photo.new_collection(response["photos"].delete("photo"), client, response["photos"])
    end

    def get_public_photos(params = {})
      response = client.get f(__method__), handle_extras(params.merge(user_id: id))
      Photo.new_collection(response["photos"].delete("photo"), client, response["photos"])
    end

    def get_public_photos_from_contacts(params = {})
      response = client.get f(__method__), handle_extras(params.merge(user_id: id))
      Photo.new_collection(response["photos"].delete("photo"), client, response["photos"])
    end

    def get_sets(params = {})
      response = client.get f(__method__), params.merge(user_id: id)
      Set.new_collection(response["photosets"].delete("photoset"), client, response["photosets"])
    end
  end
end
