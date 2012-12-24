class Flickr
  class Set < Object

    attribute :id,             String
    attribute :secret,         String
    attribute :server,         String
    attribute :farm,           Integer
    attribute :url,            String
    attribute :title,          String
    attribute :description,    String

    attribute :owner,          Person

    attribute :photos_count,   Integer
    attribute :views_count,    Integer
    attribute :comments_count, Integer

    attribute :permissions,    Permissions

    attribute :created_at,     Time
    attribute :updated_at,     Time

    attribute :primary_photo,  Photo

  end
end
