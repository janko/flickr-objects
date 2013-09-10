module Flickr
  class Object
    class Photo

      class Note

        attributes.add_locations(
          author: [
            -> {
              if @attributes["author"]
                {
                  "id"       => @attributes["author"],
                  "username" => @attributes["authorname"],
                }
              end
            },
          ],
          coordinates: [
            -> { [@attributes["x"], @attributes["y"]] if @attributes["x"] },
          ],
          width: [
            -> { @attributes["w"] },
          ],
          height: [
            -> { @attributes["h"] },
          ],
          content: [
            -> { @attributes["_content"] },
          ],
        )

      end

    end
  end
end
