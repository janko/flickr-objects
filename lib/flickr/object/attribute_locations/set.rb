module Flickr
  class Object

    class Set

      attributes.add_locations(
        owner: [
          -> {
            if @attributes["owner"]
              {
                "id"       => @attributes["owner"],
                "username" => @attributes["username"],
              }
            end
          },
        ],
        url: [
          -> { "http://www.flickr.com/photos/#{owner.id}/sets/#{id}" },
        ],
        photos_count: [
          -> { @attributes["photos"] },
          -> { @attributes["count_photos"] },
        ],
        views_count: [
          -> { @attributes["count_views"] },
        ],
        comments_count: [
          -> { @attributes["count_comments"] },
        ],
        title: [
          -> { @attributes["title"]["_content"] },
        ],
        description: [
          -> { @attributes["description"]["_content"] },
        ],
        permissions: [
          -> { {"can_comment" => @attributes["can_comment"]} },
        ],
        created_at: [
          -> { @attributes["date_create"] },
        ],
        updated_at: [
          -> { @attributes["date_update"] },
        ],
        primary_photo: [
          -> { {"id" => @attributes.fetch("primary")} },
        ],
      )

    end

  end
end
