module Flickr
  class Object
    class Photo

      class Tag

        attributes.add_locations(
          author: [
            -> { {"id" => @attributes.fetch("author")} },
          ],
          content: [
            -> { @attributes["_content"] },
          ],
          machine_tag: [
            -> { @attributes["machine_tag"] },
          ],
        )

      end

    end
  end
end
