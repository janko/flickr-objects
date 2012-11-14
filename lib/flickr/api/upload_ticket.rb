class Flickr
  class UploadTicket < Object
    def self.check(tickets, params = {})
      response = client.get flickr_method(__method__), params.merge(tickets: tickets)
      Collection.new(response["uploader"].delete("ticket"), self, response["uploader"], client)
    end
  end
end
