module Flickr
  class Object

    class Person < Flickr::Object

      autoload_names :UploadStatus

      attribute :id,                   String
      attribute :nsid,                 String
      attribute :username,             String
      attribute :real_name,            String
      attribute :location,             String
      attribute :time_zone,            Hash
      attribute :description,          String
      attribute :has_pro_account,      Boolean

      attribute :icon_server,          Integer
      attribute :icon_farm,            Integer
      attribute :buddy_icon_url,       String

      attribute :photos_url,           String
      attribute :profile_url,          String
      attribute :mobile_url,           String

      attribute :first_photo_taken,    Time
      attribute :first_photo_uploaded, Time
      attribute :favorited_at,         Time

      attribute :photos_count,         Integer
      attribute :photo_views_count,    Integer

      attribute :path_alias,           String

      ##
      # @return [self]
      # @see Flickr::Api::Person#get_info
      #
      def get_info!(params = {})
        person = api.get_info(id, params)
        update(person.attributes)
      end

      ##
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @see Flickr::Api::Person#get_photos
      #
      def get_photos(params = {})
        api.get_photos(id, params)
      end
      alias photos get_photos

      ##
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @see Flickr::Api::Person#get_photos_of
      #
      def get_photos_of(params = {})
        api.get_photos_of(id, params)
      end
      alias photos_of get_photos_of

      ##
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @see Flickr::Api::Person#get_public_photos
      #
      def get_public_photos(params = {})
        api.get_public_photos(id, params)
      end
      alias public_photos get_public_photos

      ##
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @see Flickr::Api::Person#get_public_photos_from_contacts
      #
      def get_public_photos_from_contacts(params = {})
        api.get_public_photos_from_contacts(id, params)
      end
      alias public_photos_from_contacts get_public_photos_from_contacts

      ##
      # @return [Flickr::Object::List<Flickr::Object::Set>]
      # @see Flickr::Api::Person#get_sets
      #
      def get_sets(params = {})
        api.get_sets(id, params)
      end
      alias sets get_sets

    end

  end
end

require_relative "attribute_locations/person"
