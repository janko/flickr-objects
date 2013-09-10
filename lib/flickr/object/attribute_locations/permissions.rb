module Flickr
  class Object

    class Permissions

      attributes.add_locations(
        can_comment: [
          -> { @attributes["cancomment"] },
          -> { @attributes["can_comment"] }
        ],
        can_add_meta: [
          -> { @attributes["canaddmeta"] },
        ],
        can_download: [
          -> { @attributes["candownload"] },
        ],
        can_blog: [
          -> { @attributes["canblog"] },
        ],
        can_print: [
          -> { @attributes["canprint"] },
        ],
        can_share: [
          -> { @attributes["canshare"] },
        ],
      )

    end

  end
end
