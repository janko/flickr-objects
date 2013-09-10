module Flickr
  class Object

    class Visibility

      attributes.add_locations(
        public: [
          -> { @attributes["ispublic"] },
        ],
        friends: [
          -> { @attributes["isfriend"] },
        ],
        family: [
          -> { @attributes["isfamily"] },
        ],
        contacts: [
          -> { @attributes["iscontact"] },
        ],
      )

    end

  end
end
