class Flickr
  class UploadTicket < Object

    attribute :id,      String
    attribute :status,  Integer
    attribute :invalid, Integer

    attribute :photo,   Photo

    def complete?; status == 1 end
    def failed?;   status == 2 end

    def invalid?; invalid == 1 end
  end
end
