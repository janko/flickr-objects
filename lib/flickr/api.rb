module Flickr

  module Api

    extend Flickr::AutoloadHelper

    autoload_names \
      :Abstract, :General, :Photo, :Person, :Set, :UploadTicket, :License

    ##
    # @return [Flickr::Api::Photo]
    #
    def photos
      Flickr::Api::Photo.new(access_token)
    end

    ##
    # @return [Flickr::Api::Person]
    #
    def people
      Flickr::Api::Person.new(access_token)
    end

    ##
    # @return [Flickr::Api::Set]
    #
    def sets
      Flickr::Api::Set.new(access_token)
    end

    ##
    # @return [Flickr::Api::UploadTicket]
    #
    def upload_tickets
      Flickr::Api::UploadTicket.new(access_token)
    end

    ##
    # @return [Flickr::Api::License]
    #
    def licenses
      Flickr::Api::License.new(access_token)
    end

    ##
    # @return [String]
    # @see Flickr::Api::General#upload
    #
    def upload(photo, params = {})
      api.upload(photo, params)
    end

    ##
    # @return [String]
    # @see Flickr::Api::General#replace
    #
    def replace(photo, photo_id, params = {})
      api.replace(photo, photo_id, params)
    end

    ##
    # @return [Flickr::Object::List<Flickr::Object::UploadTicket>]
    # @deprecated Use `Flickr.upload_tickets.check` instead.
    # @see Flickr::Api::UploadTicket#check
    #
    def check_upload_tickets(tickets, params = {})
      Flickr.deprecation_warn "`Flickr.check_upload_tickets` is deprecated. Use `Flickr.upload_tickets.check` instead."
      upload_tickets.check(tickets, params)
    end

    ##
    # @return [Array<String>]
    # @see Flickr::Api::General#get_methods
    #
    def get_methods(params = {})
      api.get_methods(params)
    end

    ##
    # @return [Hash]
    # @see Flickr::Api::General#test_login
    #
    def test_login(params = {})
      api.test_login(params)
    end

    ##
    # @return [Hash]
    # @see Flickr::Api::General#test_echo
    #
    def test_echo(params = {})
      api.test_echo(params)
    end

    ##
    # @return [Hash]
    # @see Flickr::Api::General#test_null
    #
    def test_null(params = {})
      api.test_null(params)
    end

    private

    def api
      Flickr::Api::General.new(access_token)
    end

  end

end
