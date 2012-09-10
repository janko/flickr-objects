class Flickr
  class Media < Object

    attribute :id,                   String
    attribute :secret,               String
    attribute :server,               String
    attribute :farm,                 Integer
    attribute :title,                String
    attribute :description,          String
    attribute :license,              Integer
    attribute :safety_level,         Integer
    attribute :visibility,           Visibility

    attribute :owner,                Person

    attribute :uploaded_at,          Time
    attribute :posted_at,            Time
    attribute :taken_at,             Time
    attribute :taken_at_granularity, Integer
    attribute :updated_at,           Time

    attribute :views_count,          Integer
    attribute :comments_count,       Integer

    attribute :editability,          Permissions
    attribute :public_editability,   Permissions
    attribute :usage,                Permissions

    attribute :notes,                Array(Note)
    attribute :tags,                 Array(Tag)

    attribute :has_people?,          Boolean
    attribute :favorite?,            Boolean

    def safe?;       safety_level <= 1 if safety_level end
    def moderate?;   safety_level == 2 if safety_level end
    def restricted?; safety_level == 3 if safety_level end

    def url
      if owner
        "http://www.flickr.com/photos/#{owner.id}/#{id}/"
      end
    end

  end
end
