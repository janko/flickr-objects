require "flickr/base_58"

class Flickr
  class Media < Object
    include Base58

    self.attribute_values = {
      uploaded_at:          [->{ @hash.fetch("dateuploaded") }, ->{ @hash.fetch("dateupload") }],
      favorite?:            [->{ @hash.fetch("isfavorite") }],
      posted_at:            [->{ @hash["dates"].fetch("posted") }],
      taken_at:             [->{ @hash["dates"].fetch("taken") }, ->{ @hash.fetch("datetaken") }],
      taken_at_granularity: [->{ @hash["dates"].fetch("takengranularity") }, ->{ @hash.fetch("datetakengranularity") }],
      updated_at:           [->{ @hash["dates"].fetch("lastupdate") }, ->{ @hash.fetch("lastupdate") }],
      views_count:          [->{ @hash.fetch("views") }],
      public_editability:   [->{ @hash.fetch("publiceditability") }],
      comments_count:       [->{ @hash["comments"].fetch("_content") }],
      has_people?:          [->{ @hash["people"].fetch("haspeople") }],
      notes:                [->{ @hash["notes"].fetch("note") }],
      tags:                 [
                              ->{ @hash["tags"].fetch("tag").map { |h| h.merge("photo_id" => @hash["id"]) } },
                              ->{
                                [
                                  *@hash["tags"].split(" ").map         {|content| {"_content" => content, "machine_tag" => 0} },
                                  *@hash["machine_tags"].split(" ").map {|content| {"_content" => content, "machine_tag" => 1} }
                                ]
                              }
                            ],
      visibility:           [->{ @hash.fetch("visibility") }, ->{ @hash.slice("ispublic", "isfriend", "isfamily") }],
      title:                [->{ @hash["title"].fetch("_content") }],
      description:          [->{ @hash["description"].fetch("_content") }],
      owner:                [
                              ->{
                                if @hash["owner"].is_a?(String)
                                  {
                                    "id"         => @hash["owner"],
                                    "username"   => @hash["ownername"],
                                    "iconserver" => @hash["iconserver"],
                                    "iconfarm"   => @hash["iconfarm"],
                                  }
                                end
                              }
                            ],
      path_alias:           [->{ @hash.fetch("pathalias") }],
      location_visibility:  [
                              ->{ @hash.fetch("geoperms") },
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
      safe?:                [->{ safety_level <= 1 }],
      moderate?:            [->{ safety_level == 2 }],
      restricted?:          [->{ safety_level == 3 }],
      url:                  [->{ "http://www.flickr.com/photos/#{owner.id}/#{id}/" }],
      short_url:            [->{ "http://flic.kr/p/#{to_base58(id)}" }],
      largest_size:         [->{ SIZES.key(SIZES.values.reverse.find { |abbr| @hash["url_#{abbr}"] }) }],
      size:                 [->{ @size }],
    }

    private

    def size_abbr(size = @size)
      SIZES[size]
    end
  end
end
