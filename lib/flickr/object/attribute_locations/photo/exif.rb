module Flickr
  class Object
    class Photo

      class Exif

        attributes.add_locations(
          items: [
            -> { @attributes },
          ],
        )

        Item.attributes.add_locations(
          tagspace_id: [
            -> { @attributes["tagspaceid"] },
          ],
          raw: [
            -> { @attributes["raw"]["_content"] },
          ],
          clean: [
            -> { @attributes["clean"]["_content"] },
          ],
        )

      end

    end
  end
end
