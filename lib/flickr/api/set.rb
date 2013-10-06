module Flickr
  module Api

    class Set < Abstract

      ##
      # @param params [Hash] See documentation below
      # @return [Flickr::Object::Set]
      # @docs [flickr.photosets.create](http://www.flickr.com/services/api/flickr.photosets.create.html)
      #
      def create(params = {})
        response = post "photosets.create", params
        new_object(:Set, response["photoset"])
      end

      ##
      # @param set_ids [String] Comma-delimited list of set IDs (see documentation below)
      # @return [response]
      # @docs [flickr.photosets.orderSets](http://www.flickr.com/services/api/flickr.photosets.orderSets.html)
      #
      def order(set_ids, params = {})
        post "photosets.orderSets", params.merge(photoset_ids: set_ids)
      end

      ##
      # @param set_id [String]
      # @return [response]
      # @docs [flickr.photosets.delete](http://www.flickr.com/services/api/flickr.photosets.delete.html)
      #
      def delete(set_id, params = {})
        post "photosets.delete", params.merge(photoset_id: set_id)
      end

      ##
      # @param set_id [String]
      # @param params [Hash] See documentation below
      # @return [response]
      # @docs [flickr.photosets.editPhotos](http://www.flickr.com/services/api/flickr.photosets.editPhotos.html)
      #
      def edit_photos(set_id, params = {})
        post "photosets.editPhotos", params.merge(photoset_id: set_id)
      end

      ##
      # @param set_id [String]
      # @param params [Hash] See documentation below
      # @return [Flickr::Object::Set]
      # @docs [flickr.photosets.getInfo](http://www.flickr.com/services/api/flickr.photosets.getInfo.html)
      #
      def get_info(set_id, params = {})
        response = get "photosets.getInfo", params.merge(photoset_id: set_id)
        new_object(:Set, response["photoset"])
      end

      ##
      # @param set_id [String]
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photosets.getPhotos](http://www.flickr.com/services/api/flickr.photosets.getPhotos.html)
      #
      def get_photos(set_id, params = {})
        response = get "photosets.getPhotos", params.merge(photoset_id: set_id)
        new_list(:Photo, response["photoset"].delete("photo").map { |h| h.merge("owner" => response["photoset"]["owner"]) }, response["photoset"])
      end

      ##
      # @param set_id [String]
      # @param photo_id [String]
      # @param params [Hash] See documentation below
      # @return [response]
      # @docs [flickr.photosets.addPhoto](http://www.flickr.com/services/api/flickr.photosets.addPhoto.html)
      #
      def add_photo(set_id, photo_id, params = {})
        post "photosets.addPhoto", params.merge(photoset_id: set_id, photo_id: photo_id)
      end

      ##
      # @param set_id [String]
      # @param photo_ids [String] Comma-delimited list of photo IDs (see documentation below)
      # @return [response]
      # @docs [flickr.photosets.removePhotos](http://www.flickr.com/services/api/flickr.photosets.removePhotos.html)
      #
      def remove_photos(set_id, photo_ids, params = {})
        post "photosets.removePhotos", params.merge(photoset_id: set_id, photo_ids: photo_ids)
      end

      ##
      # @param set_id [String]
      # @param photo_id [String]
      # @return [response]
      # @docs [flickr.photosets.removePhoto](http://www.flickr.com/services/api/flickr.photosets.removePhoto.html)
      #
      def remove_photo(set_id, photo_id, params = {})
        post "photosets.removePhoto", params.merge(photoset_id: set_id, photo_id: photo_id)
      end

      ##
      # @param set_id [String]
      # @param params [Hash] See documentation below
      # @return [response]
      # @docs [flickr.photosets.editMeta](http://www.flickr.com/services/api/flickr.photosets.editMeta.html)
      #
      def edit_meta(set_id, params = {})
        post "photosets.editMeta", params.merge(photoset_id: set_id)
      end

      ##
      # @param set_id [String]
      # @param photo_ids [String] Comma-delimited list of photo IDs (see documentation below)
      # @return [response]
      # @docs [flickr.photosets.reorderPhotos](http://www.flickr.com/services/api/flickr.photosets.reorderPhotos.html)
      #
      def reorder_photos(set_id, photo_ids, params = {})
        post "photosets.reorderPhotos", params.merge(photoset_id: set_id, photo_ids: photo_ids)
      end

      ##
      # @param set_id [String]
      # @param photo_id [String]
      # @return [response]
      # @docs [flickr.photosets.setPrimaryPhoto](http://www.flickr.com/services/api/flickr.photosets.setPrimaryPhoto.html)
      #
      def set_primary_photo(set_id, photo_id, params = {})
        post "photosets.setPrimaryPhoto", params.merge(photoset_id: set_id, photo_id: photo_id)
      end

    end

  end
end
