module Flickr
  module Api

    class Photo < Abstract

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.search](http://www.flickr.com/services/api/flickr.photos.search.html)
      #
      def search(params = {})
        response = get "photos.search", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.getContactsPhotos](http://www.flickr.com/services/api/flickr.photos.getContactsPhotos.html)
      #
      def get_from_contacts(params = {})
        response = get "photos.getContactsPhotos", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.getNotInSet](http://www.flickr.com/services/api/flickr.photos.getNotInSet.html)
      #
      def get_not_in_set(params = {})
        response = get "photos.getNotInSet", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.getRecent](http://www.flickr.com/services/api/flickr.photos.getRecent.html)
      #
      def get_recent(params = {})
        response = get "photos.getRecent", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end
      
      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.interestingness.getList](www.flickr.com/services/api/flickr.interestingness.getList.html)
      #
      def get_interesting(params = {})
        response = get "interestingness.getList", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.getUntagged](http://www.flickr.com/services/api/flickr.photos.getUntagged.html)
      #
      def get_untagged(params = {})
        response = get "photos.getUntagged", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.getWithGeoData](http://www.flickr.com/services/api/flickr.photos.getWithGeoData.html)
      #
      def get_with_geo_data(params = {})
        response = get "photos.getWithGeoData", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.getWithoutGeoData](http://www.flickr.com/services/api/flickr.photos.getWithoutGeoData.html)
      #
      def get_without_geo_data(params = {})
        response = get "photos.getWithoutGeoData", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.RecentlyUpdated](http://www.flickr.com/services/api/flickr.photos.RecentlyUpdated.html)
      #
      def get_recently_updated(params = {})
        response = get "photos.recentlyUpdated", params
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param photo_id [String]
      # @return [Flickr::Object::Photo]
      # @docs [flickr.photos.getInfo](http://www.flickr.com/services/api/flickr.photos.getInfo.html)
      #
      def get_info(photo_id, params = {})
        response = get "photos.getInfo", params.merge(photo_id: photo_id)
        new_object(:Photo, response["photo"])
      end

      ##
      # @param photo_id [String]
      # @return [Flickr::Object::Photo]
      # @docs [flickr.photos.getSizes](http://www.flickr.com/services/api/flickr.photos.getInfo.html)
      #
      def get_sizes(photo_id, params = {})
        response = get "photos.getSizes", params.merge(photo_id: photo_id)
        new_object(:Photo, response)
      end

      ##
      # @param photo_id [String]
      # @return [Flickr::Object::Photo]
      # @docs [flickr.photos.getExif](http://www.flickr.com/services/api/flickr.photos.getInfo.html)
      #
      def get_exif(photo_id, params = {})
        response = get "photos.getExif", params.merge(photo_id: photo_id)
        new_object(:Photo, response["photo"])
      end

      ##
      # @param photo_id [String]
      # @return [Flickr::Object::List<Flickr::Object::Person>]
      # @docs [flickr.photos.getFavorites](http://www.flickr.com/services/api/flickr.photos.getFavorites.html)
      #
      def get_favorites(photo_id, params = {})
        response = get "photos.getFavorites", params.merge(photo_id: photo_id)
        new_list(:Person, response["photo"].delete("person"), response["photo"])
      end

      ##
      # @param photo_id [String]
      # @return [response]
      # @docs [flickr.photos.delete](http://www.flickr.com/services/api/flickr.photos.delete.html)
      #
      def delete(photo_id, params = {})
        post "photos.delete", params.merge(photo_id: photo_id)
      end

      ##
      # @param photo_id [String]
      # @param content_type [String]
      # @return [response]
      # @docs [flickr.photos.setContentType](http://www.flickr.com/services/api/flickr.photos.setContentType.html)
      #
      def set_content_type(photo_id, content_type, params = {})
        post "photos.setContentType", params.merge(photo_id: photo_id, content_type: content_type)
      end

      ##
      # @param photo_id [String]
      # @param tags [String] Space-delimited list of tags (see documentation below)
      # @return [response]
      # @docs [flickr.photos.setTags](http://www.flickr.com/services/api/flickr.photos.setTags.html)
      #
      def set_tags(photo_id, tags, params = {})
        post "photos.setTags", params.merge(photo_id: photo_id, tags: tags)
      end

      ##
      # @param photo_id [String]
      # @param tags [String] Space-delimited list of tags (see documentation below)
      # @return [response]
      # @docs [flickr.photos.addTags](http://www.flickr.com/services/api/flickr.photos.addTags.html)
      #
      def add_tags(photo_id, tags, params = {})
        post "photos.addTags", params.merge(photo_id: photo_id, tags: tags)
      end

      ##
      # @param photo_id [String]
      # @param tag_id [String]
      # @return [response]
      # @docs [flickr.photos.removeTag](http://www.flickr.com/services/api/flickr.photos.removeTag.html)
      #
      def remove_tag(photo_id, tag_id, params = {})
        post "photos.removeTag", params.merge(photo_id: photo_id, tag_id: tag_id)
      end

      ##
      # @param photo_id [String]
      # @param params [Hash] See documentation below
      # @return [response]
      # @docs [flickr.photos.setDates](http://www.flickr.com/services/api/flickr.photos.setDates.html)
      #
      def set_dates(photo_id, params = {})
        post "photos.setDates", params.merge(photo_id: photo_id)
      end

      ##
      # @param photo_id [String]
      # @param params [Hash] See documentation below
      # @return [response]
      # @docs [flickr.photos.setMeta](http://www.flickr.com/services/api/flickr.photos.setMeta.html)
      #
      def set_meta(photo_id, params = {})
        post "photos.setMeta", params.merge(photo_id: photo_id)
      end

      ##
      # @param photo_id [String]
      # @param params [Hash] See documentation below
      # @return [response]
      # @docs [flickr.photos.setPerms](http://www.flickr.com/services/api/flickr.photos.setPerms.html)
      #
      def set_permissions(photo_id, params = {})
        post "photos.setPerms", params.merge(photo_id: photo_id)
      end

      ##
      # @param photo_id [String]
      # @param params [Hash] See documentation below
      # @return [response]
      # @docs [flickr.photos.setSafetyLevel](http://www.flickr.com/services/api/flickr.photos.setSafetyLevel.html)
      #
      def set_safety_level(photo_id, params = {})
        post "photos.setSafetyLevel", params.merge(photo_id: photo_id)
      end

    end

  end
end
