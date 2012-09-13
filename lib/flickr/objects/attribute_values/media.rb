class Flickr
  class Media < Object
    self.attribute_values = {
      uploaded_at:          [proc {|hash| hash.fetch("dateuploaded") }],
      favorite?:            [proc {|hash| hash.fetch("isfavorite") }],
      posted_at:            [proc {|hash| hash["dates"].fetch("posted") }],
      taken_at:             [proc {|hash| hash["dates"].fetch("taken") }],
      taken_at_granularity: [proc {|hash| hash["dates"].fetch("takengranularity") }],
      updated_at:           [proc {|hash| hash["dates"].fetch("lastupdate") }],
      views_count:          [proc {|hash| hash.fetch("views") }],
      public_editability:   [proc {|hash| hash.fetch("publiceditability") }],
      comments_count:       [proc {|hash| hash.fetch("comments") }],
      has_people?:          [proc {|hash| hash["people"].fetch("haspeople") }],
      notes:                [proc {|hash| hash["notes"].fetch("note") }],
      tags:                 [proc {|hash| hash["tags"].fetch("tag").map { |h| h.merge("photo_id" => hash["id"]) } }],
      visibility:           [proc {|hash| hash.fetch("visibility") }, proc {|hash| {"ispublic" => hash["ispublic"], "isfriend" => hash["isfriend"], "isfamily" => hash["isfamily"]} }]
    }
  end
end
