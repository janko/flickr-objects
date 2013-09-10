module Flickr
  class Object

    class Set < Flickr::Object

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

      ##
      # @return [response]
      # @see Flickr::Api::Set#delete
      #
      def delete(params = {})
        api.delete(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Set#edit_photos
      #
      def edit_photos(params = {})
        api.edit_photos(id, params)
      end

      ##
      # @return [self]
      # @see Flickr::Api::Set#get_info
      #
      def get_info!(params = {})
        set = api.get_info(id, params)
        update(set.attributes)
      end

      ##
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @see Flickr::Api::Set#get_photos
      #
      def get_photos(params = {})
        api.get_photos(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Set#add_photo
      #
      def add_photo(photo_or_id, params = {})
        api.add_photo(id, photo_or_id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Set#remove_photos
      #
      def remove_photos(photo_ids, params = {})
        api.remove_photos(id, photo_ids, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Set#remove_photo
      #
      def remove_photo(photo_or_id, params = {})
        api.remove_photo(id, photo_or_id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Set#edit_meta
      #
      def edit_meta(params = {})
        api.edit_meta(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Set#reorder_photos
      #
      def reorder_photos(photo_ids, params = {})
        api.reorder_photos(id, photo_ids, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Set#set_primary_photo
      #
      def set_primary_photo(photo_or_id, params = {})
        api.set_primary_photo(id, photo_or_id, params)
      end
      alias primary_photo= set_primary_photo

    end

  end
end

require_relative "attribute_locations/set"
