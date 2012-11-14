class Flickr
  class UploadTicket < Object

    attribute :id,        String
    attribute :status,    Integer
    attribute :invalid?,  Boolean

    attribute :media,     Media
    attribute :photo,     Photo
    attribute :video,     Video

    def complete?; status == 1 end
    def failed?;   status == 2 end

  end
end
