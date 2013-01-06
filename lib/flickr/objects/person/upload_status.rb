require_relative "../attribute_values/person/upload_status"

class Flickr
  class Person::UploadStatus < Object
    class Month < Object
      attribute :maximum,   Integer
      attribute :used,      Integer
      attribute :remaining, Integer
    end

    attribute :current_month,      Month
    attribute :maximum_photo_size, Integer
  end
end
