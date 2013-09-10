module Flickr
  class Object

    class UploadTicket < Flickr::Object

      attribute :id,       String

      attribute :status,   Integer
      attribute :complete, Boolean
      attribute :failed,   Boolean

      attribute :valid,    Boolean
      attribute :invalid,  Boolean

      attribute :photo,    Photo

      ##
      # @return [self]
      # @see Flickr::Api::UploadTicket#check
      #
      def get_info!(params = {})
        ticket = api.check(id, params).first
        update(ticket.attributes)
      end

    end

  end
end

require_relative "attribute_locations/upload_ticket"
