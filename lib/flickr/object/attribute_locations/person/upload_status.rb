module Flickr
  class Object
    class Person

      class UploadStatus

        Month.attributes.add_locations(
          maximum: [
            -> { @attributes["maxkb"] / 1024 },
          ],
          used: [
            -> { @attributes["usedkb"] / 1024 },
          ],
          remaining: [
            -> { @attributes["remainingkb"] / 1024 },
          ],
        )

        attributes.add_locations(
          current_month: [
            -> { @attributes["bandwidth"] },
          ],
          maximum_photo_size: [
            -> { @attributes["filesize"]["maxmb"] },
          ],
        )

      end

    end
  end
end
