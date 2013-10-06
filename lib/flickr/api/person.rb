module Flickr
  module Api

    class Person < Abstract

      ##
      # @param email [String]
      # @return [Flickr::Object::Person]
      # @docs [flickr.people.findByEmail](http://www.flickr.com/services/api/flickr.people.findByEmail.html)
      #
      def find_by_email(email, params = {})
        response = get "people.findByEmail", params.merge(find_email: email)
        new_object(:Person, response["user"])
      end

      ##
      # @param username [String]
      # @return [Flickr::Object::Person]
      # @docs [flickr.people.findByUsername](http://www.flickr.com/services/api/flickr.people.findByUsername.html)
      #
      def find_by_username(username, params = {})
        response = get "people.findByUsername", params.merge(username: username)
        new_object(:Person, response["user"])
      end

      ##
      # @return [Flickr::Object::Person::UploadStatus]
      # @docs [flickr.people.getUploadStatus](http://www.flickr.com/services/api/flickr.people.getUploadStatus.html)
      #
      def get_upload_status(params = {})
        response = get "people.getUploadStatus", params
        new_object(:UploadStatus, response["user"])
      end

      ##
      # @param person_id [String]
      # @return [Flickr::Object::Person]
      # @docs [flickr.people.getInfo](http://www.flickr.com/services/api/flickr.people.getInfo.html)
      #
      def get_info(person_id, params = {})
        response = get "people.getInfo", params.merge(user_id: person_id)
        new_object(:Person, response["person"])
      end

      ##
      # @param person_id [String]
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.people.getPhotos](http://www.flickr.com/services/api/flickr.people.getPhotos.html)
      #
      def get_photos(person_id, params = {})
        response = get "people.getPhotos", params.merge(user_id: person_id)
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param person_id [String]
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.people.getPhotosOf](http://www.flickr.com/services/api/flickr.people.getPhotosOf.html)
      #
      def get_photos_of(person_id, params = {})
        response = get "people.getPhotosOf", params.merge(user_id: person_id)
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param person_id [String]
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.people.getPublicPhotos](http://www.flickr.com/services/api/flickr.people.getPublicPhotos.html)
      #
      def get_public_photos(person_id, params = {})
        response = get "people.getPublicPhotos", params.merge(user_id: person_id)
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param person_id [String]
      # @param params [Hash] See documentation below
      # @option params [Boolean, Array<String>] :sizes For all sizes use `true`, for specific ones
      #   chuck them into an array (e.g. `["Square 75", "Medium 500"]`).
      # @return [Flickr::Object::List<Flickr::Object::Photo>]
      # @docs [flickr.photos.getContactsPublicPhotos](http://www.flickr.com/services/api/flickr.photos.getContactsPublicPhotos.html)
      #
      def get_public_photos_from_contacts(person_id, params = {})
        response = get "photos.getContactsPublicPhotos", params.merge(user_id: person_id)
        new_list(:Photo, response["photos"].delete("photo"), response["photos"])
      end

      ##
      # @param person_id [String]
      # @param params [Hash] See documentation below
      # @return [Flickr::Object::List<Flickr::Object::Set>]
      # @docs [flickr.photosets.getList](http://www.flickr.com/services/api/flickr.photosets.getList.html)
      #
      def get_sets(person_id, params = {})
        response = get "photosets.getList", params.merge(user_id: person_id)
        new_list(:Set, response["photosets"].delete("photoset"), response["photosets"])
      end

    end

  end
end
