module Flickr
  class Object

    class Person

      attributes.add_locations(
        id: [
          -> { @attributes["nsid"] },
        ],
        nsid: [
          -> { id },
        ],
        username: [
          -> { @attributes["username"]["_content"] },
        ],
        real_name: [
          -> { @attributes["realname"].fetch("_content") },
          -> { @attributes["realname"] },
        ],
        icon_server: [
          -> { @attributes["iconserver"] },
        ],
        icon_farm: [
          -> { @attributes["iconfarm"] },
        ],
        buddy_icon_url: [
          -> {
            if icon_farm && icon_server && id
              if icon_server > 0
                "http://farm#{icon_farm}.staticflickr.com/#{icon_server}/buddyicons/#{id}.jpg"
              else
                "http://www.flickr.com/images/buddyicon.jpg"
              end
            end
          },
        ],
        has_pro_account: [
          -> { @attributes["ispro"] },
        ],
        location: [
          -> { @attributes["location"]["_content"] },
        ],
        time_zone: [
          -> { @attributes["timezone"] },
        ],
        description: [
          -> { @attributes["description"]["_content"] },
        ],
        photos_url: [
          -> { @attributes["photosurl"]["_content"] },
        ],
        profile_url: [
          -> { @attributes["profileurl"]["_content"] },
        ],
        mobile_url: [
          -> { @attributes["mobileurl"]["_content"] },
        ],
        first_photo_taken: [
          -> { @attributes["photos"]["firstdatetaken"]["_content"] },
        ],
        first_photo_uploaded: [
          -> { @attributes["photos"]["firstdate"]["_content"] },
        ],
        favorited_at: [
          -> { @attributes["favedate"] },
        ],
        photos_count: [
          -> { @attributes["photos"]["count"]["_content"] },
        ],
        photo_views_count: [
          -> { @attributes["photos"]["views"]["_content"] },
        ],
      )

    end

  end
end
