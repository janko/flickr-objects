module Flickr
  module Api

    class UploadTicket < Abstract

      ##
      # Used to check the status of a photo uploaded or replaced asynchronously.
      #
      # @param ticket_ids [String] Comma-delimited list of ticket IDs (see documentation below)
      # @return [Flickr::Object::List<Flickr::Object::UploadTicket>]
      # @docs [flickr.photos.upload.checkTickets](http://www.flickr.com/services/api/flickr.photos.upload.checkTickets.html)
      #
      def check(ticket_ids, params = {})
        response = get "photos.upload.checkTickets", params.merge(tickets: ticket_ids)
        new_list(:UploadTicket, response["uploader"]["ticket"], response["uploader"])
      end

    end

  end
end
