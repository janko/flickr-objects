class Flickr
  class Media < Object
    self.attribute_values = {
      uploaded_at:          [proc {|hash| hash.fetch("dateuploaded") }, proc {|hash| hash.fetch("dateupload") }],
      favorite?:            [proc {|hash| hash.fetch("isfavorite") }],
      posted_at:            [proc {|hash| hash["dates"].fetch("posted") }],
      taken_at:             [proc {|hash| hash["dates"].fetch("taken") }, proc {|hash| hash.fetch("datetaken") }],
      taken_at_granularity: [proc {|hash| hash["dates"].fetch("takengranularity") }, proc {|hash| hash.fetch("datetakengranularity") }],
      updated_at:           [proc {|hash| hash["dates"].fetch("lastupdate") }, proc {|hash| hash.fetch("lastupdate") }],
      views_count:          [proc {|hash| hash.fetch("views") }],
      public_editability:   [proc {|hash| hash.fetch("publiceditability") }],
      comments_count:       [proc {|hash| hash["comments"].fetch("_content") }],
      has_people?:          [proc {|hash| hash["people"].fetch("haspeople") }],
      notes:                [proc {|hash| hash["notes"].fetch("note") }],
      tags:                 [proc {|hash| hash["tags"].fetch("tag").map { |h| h.merge("photo_id" => hash["id"]) } },
                             proc {|hash| [*hash["tags"].split(" ").map { |content| {"_content" => content, "machine_tag" => 0} }, *hash["machine_tags"].split(" ").map { |c| {"_content" => content, "machine_tag" => 1} }] }],
      visibility:           [proc {|hash| hash.fetch("visibility") }, proc {|hash| hash.slice("ispublic", "isfriend", "isfamily") }],
      title:                [proc {|hash| hash["title"].fetch("_content") }],
      description:          [proc {|hash| hash["description"].fetch("_content") }],
      owner:                [proc {|hash| hash.slice("owner", "ownername", "iconserver", "iconfarm") if hash["owner"].is_a?(String) }],
      path_alias:           [proc {|hash| hash.fetch("pathalias") }]
    }
  end
end
