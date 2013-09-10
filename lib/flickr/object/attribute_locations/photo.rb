require "flickr/base_converter"

module Flickr
  class Object

    class Photo

      attributes.add_locations(
        uploaded_at: [
          -> { @attributes["dateuploaded"] },
          -> { @attributes["dateupload"] },
        ],
        favorite: [
          -> { @attributes["isfavorite"] },
        ],
        posted_at: [
          -> { @attributes["dates"]["posted"] },
        ],
        taken_at: [
          -> { @attributes["dates"]["taken"] },
          -> { @attributes["datetaken"] }
        ],
        taken_at_granularity: [
          -> { @attributes["dates"]["takengranularity"] },
          -> { @attributes["datetakengranularity"] },
        ],
        updated_at: [
          -> { @attributes["dates"]["lastupdate"] },
          -> { @attributes["lastupdate"] },
        ],
        views_count: [
          -> { @attributes["views"] },
        ],
        public_editability: [
          -> { @attributes["publiceditability"] },
        ],
        comments_count: [
          -> { @attributes["comments"]["_content"] },
        ],
        has_people: [
          -> { @attributes["people"]["haspeople"] },
        ],
        safe: [
          -> { safety_level <= 1 },
        ],
        moderate: [
          -> { safety_level == 2 },
        ],
        restricted: [
          -> { safety_level == 3 },
        ],
        notes: [
          -> { @attributes["notes"]["note"] },
        ],
        tags: [
          -> {
            @attributes["tags"]["tag"].map do |hash|
              hash.merge("photo_id" => id)
            end
          },
          -> {
            tags = @attributes["tags"].split(" ").map do |content|
              {"_content" => content, "machine_tag" => 0}
            end
            machine_tags = @attributes["machine_tags"].split(" ").map do |content|
              {"_content" => content, "machine_tag" => 1}
            end

            tags + machine_tags
          },
        ],
        visibility: [
          -> {
            {
              "ispublic" => @attributes.fetch("ispublic"),
              "isfriend" => @attributes.fetch("isfriend"),
              "isfamily" => @attributes.fetch("isfamily"),
            }
          }
        ],
        title: [
          -> { @attributes["title"]["_content"] },
        ],
        description: [
          -> { @attributes["description"]["_content"] },
        ],
        owner: [
          -> {
            if @attributes["owner"].is_a?(String)
              {
                "nsid"       => @attributes["owner"],
                "username"   => @attributes["ownername"] || @attributes["username"],
                "iconserver" => @attributes["iconserver"],
                "iconfarm"   => @attributes["iconfarm"],
              }
            end
          },
        ],
        path_alias: [
          -> { @attributes["pathalias"] },
        ],
        location_visibility: [
          -> { @attributes["geoperms"] },
          -> {
            {
              "isfamily"  => @attributes.fetch("geo_is_family"),
              "isfriend"  => @attributes.fetch("geo_is_friend"),
              "iscontact" => @attributes.fetch("geo_is_contact"),
              "ispublic"  => @attributes.fetch("geo_is_public"),
            }
          }
        ],
        location: [
          -> {
            {
              "latitude"  => @attributes.fetch("latitude"),
              "longitude" => @attributes.fetch("longitude"),
              "accuracy"  => @attributes["accuracy"],
              "context"   => @attributes["context"],
              "place_id"  => @attributes["place_id"],
              "woeid"     => @attributes["woeid"],
            }
          },
        ],
        available_sizes: [
          -> {
            sizes = Size.all.select do |size|
              @attributes["url_#{size.abbreviation}"] or
              @attributes["sizes"] && @attributes["sizes"]["size"].find { |h| h["label"] == size.label }
            end

            sizes.map(&:name)
          },
        ],
        largest_size: [
          -> { available_sizes.last },
        ],
        rotation: [
          -> { @attributes["rotation"] },
        ],
        source_url: [
          -> { @attributes["url_#{@size.abbreviation}"] },
          -> { @attributes["sizes"]["size"].find { |hash| hash["label"] == @size.label }["source"] }
        ],
        height: [
          -> { @attributes["height_#{@size.abbreviation}"] },
          -> { @attributes["sizes"]["size"].find { |hash| hash["label"] == @size.label }["height"] }
        ],
        width: [
          -> { @attributes["width_#{@size.abbreviation}"] },
          -> { @attributes["sizes"]["size"].find { |hash| hash["label"] == @size.label }["width"] }
        ],
        url: [
          -> { "http://www.flickr.com/photos/#{owner.id}/#{id}" if owner.id && id },
        ],
        short_url: [
          -> { "http://flic.kr/p/#{BaseConverter.to_base58(id)}" if id },
        ],
      )

    end

  end
end
