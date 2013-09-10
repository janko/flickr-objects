module Flickr
  class Object

    class UploadTicket

      attributes.add_locations(
        status: [
          -> { @attributes["complete"] },
        ],
        complete: [
          -> { status == 1 },
        ],
        failed: [
          -> { status == 2 },
        ],
        invalid: [
          -> { @attributes["invalid"] || 0},
        ],
        valid: [
          -> { not invalid? },
        ],
        photo: [
          -> { {"id" => @attributes.fetch("photoid")} },
        ],
      )

    end

  end
end
