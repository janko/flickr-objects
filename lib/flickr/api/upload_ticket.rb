class Flickr
  class UploadTicket < Object
    def self.check(tickets, params = {})
      response = client.get f(__method__), params.merge(tickets: tickets)
      new_collection(response["uploader"].delete("ticket"), client, response["uploader"])
    end
  end
end
