class Flickr
  def initialize(*access_token)
    @client = Client.new(access_token.flatten)
  end

  def photos
    Class.new(Photo).tap do |klass|
      klass.instance_variable_set("@client", @client)
    end
  end
end
