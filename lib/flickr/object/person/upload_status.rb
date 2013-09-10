module Flickr
  class Object
    class Person

      class UploadStatus < Flickr::Object

        class Month < Object
          attribute :maximum,   Integer
          attribute :used,      Integer
          attribute :remaining, Integer
        end

        attribute :current_month,      Month
        attribute :maximum_photo_size, Integer

      end

    end
  end
end

require_relative "../attribute_locations/person/upload_status"
