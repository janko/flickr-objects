module Flickr
  class Object

    class List

      attributes.add_locations(
        current_page: [
          -> { @attributes["page"] },
        ],
        per_page: [
          -> { @attributes["per_page"] },
          -> { @attributes["perpage"] },
        ],
        total_entries: [
          -> { @attributes["total"] },
        ],
        total_pages: [
          -> { @attributes["pages"] },
        ],
      )

    end

  end
end
