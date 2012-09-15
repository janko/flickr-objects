class Flickr
  class Media < Object
    self.attribute_values = {
      uploaded_at:          [proc { @hash.fetch("dateuploaded") }, proc { @hash.fetch("dateupload") }],
      favorite?:            [proc { @hash.fetch("isfavorite") }],
      posted_at:            [proc { @hash["dates"].fetch("posted") }],
      taken_at:             [proc { @hash["dates"].fetch("taken") }, proc { @hash.fetch("datetaken") }],
      taken_at_granularity: [proc { @hash["dates"].fetch("takengranularity") }, proc { @hash.fetch("datetakengranularity") }],
      updated_at:           [proc { @hash["dates"].fetch("lastupdate") }, proc { @hash.fetch("lastupdate") }],
      views_count:          [proc { @hash.fetch("views") }],
      public_editability:   [proc { @hash.fetch("publiceditability") }],
      comments_count:       [proc { @hash["comments"].fetch("_content") }],
      has_people?:          [proc { @hash["people"].fetch("haspeople") }],
      notes:                [proc { @hash["notes"].fetch("note") }],
      tags:                 [proc { @hash["tags"].fetch("tag").map { |h| h.merge("photo_id" => @hash["id"]) } },
                             proc { [*@hash["tags"].split(" ").map { |content| {"_content" => content, "machine_tag" => 0} }, *@hash["machine_tags"].split(" ").map { |c| {"_content" => content, "machine_tag" => 1} }] }],
      visibility:           [proc { @hash.fetch("visibility") }, proc { @hash.slice("ispublic", "isfriend", "isfamily") }],
      title:                [proc { @hash["title"].fetch("_content") }],
      description:          [proc { @hash["description"].fetch("_content") }],
      owner:                [proc { {"id" => @hash["owner"], "username" => @hash["ownername"]}.merge(@hash.slice("iconserver", "iconfarm")) if @hash["owner"].is_a?(String) }],
      path_alias:           [proc { @hash.fetch("pathalias") }],
    }
  end
end
