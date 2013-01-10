class Flickr
  class Photo < Object
    self.attribute_values = {
      uploaded_at:          [->{ @hash["dateuploaded"] }, ->{ @hash["dateupload"] }],
      favorite?:            [->{ @hash["isfavorite"] }],
      posted_at:            [->{ @hash["dates"]["posted"] }],
      taken_at:             [->{ @hash["dates"]["taken"] }, ->{ @hash["datetaken"] }],
      taken_at_granularity: [->{ @hash["dates"]["takengranularity"] }, ->{ @hash["datetakengranularity"] }],
      updated_at:           [->{ @hash["dates"]["lastupdate"] }, ->{ @hash["lastupdate"] }],
      views_count:          [->{ @hash["views"] }],
      public_editability:   [->{ @hash["publiceditability"] }],
      comments_count:       [->{ @hash["comments"]["_content"] }],
      has_people?:          [->{ @hash["people"]["haspeople"] }],
      notes:                [->{ @hash["notes"]["note"] }],
      tags:                 [
                              ->{ @hash["tags"]["tag"].map { |h| h.merge("photo_id" => @hash["id"]) } },
                              ->{
                                [
                                  *@hash["tags"].split(" ").map         {|content| {"_content" => content, "machine_tag" => 0} },
                                  *@hash["machine_tags"].split(" ").map {|content| {"_content" => content, "machine_tag" => 1} }
                                ]
                              }
                            ],
      visibility:           [->{ @hash["visibility"] }, ->{ @hash.slice("ispublic", "isfriend", "isfamily") if @hash["ispublic"] }],
      title:                [->{ @hash["title"]["_content"] }],
      description:          [->{ @hash["description"]["_content"] }],
      owner:                [
                              ->{
                                if @hash["owner"].is_a?(String)
                                  {
                                    "id"         => @hash["owner"],
                                    "username"   => @hash["ownername"] || @hash["username"],
                                    "iconserver" => @hash["iconserver"],
                                    "iconfarm"   => @hash["iconfarm"],
                                  }
                                end
                              }
                            ],
      path_alias:           [->{ @hash["pathalias"] }],
      location_visibility:  [
                              ->{ @hash["geoperms"] },
                              ->{
                                {
                                  "isfamily"  => @hash.fetch("geo_is_family"),
                                  "isfriend"  => @hash.fetch("geo_is_friend"),
                                  "iscontact" => @hash.fetch("geo_is_contact"),
                                  "ispublic"  => @hash.fetch("geo_is_public")
                                }
                              }
                            ],
      location:             [->{ @hash.slice("latitude", "longitude", "accuracy", "context", "place_id", "woeid") if @hash["latitude"] }],
      largest_size:         [->{ SIZES.key(SIZES.values.reverse.find { |abbr| @hash["url_#{abbr}"] }) }],
      available_sizes:      [->{ SIZES.select { |_, abbr| @hash["url_#{abbr}"] }.keys }],
      rotation:             [->{ @hash["rotation"] }],
      source_url:           [
                              ->{ @hash["url_#{SIZES[size]}"] },
                              ->{ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["source"] }
                            ],
      height:               [
                              ->{ @hash["height_#{SIZES[size]}"] },
                              ->{ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["height"] }
                            ],
      width:                [
                              ->{ @hash["width_#{SIZES[size]}"] },
                              ->{ @hash["size"].find { |hash| hash["label"] == OTHER_SIZES[size] }["width"] }
                            ],
      exif:                 [->{ {"items" => @hash.fetch("exif")} }],
    }

    OTHER_SIZES = {
      "Square 75"  => "Square",
      "Thumbnail"  => "Thumbnail",
      "Square 150" => "Large Square",
      "Small 240"  => "Small",
      "Small 320"  => "Small 320",
      "Medium 500" => "Medium",
      "Medium 640" => "Medium 640",
      "Medium 800" => "Medium 800",
      "Large 1024" => "Large",
      "Large 1600" => "Large 1600",
      "Large 2048" => "Large 2048",
      "Original"   => "Original"
    }
  end
end
