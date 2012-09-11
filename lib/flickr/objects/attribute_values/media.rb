class Flickr
  class Media < Object
    self.attribute_values = {
      uploaded_at:          [->(h) { h["dateuploaded"] }],
      favorite?:            [->(h) { h["isfavorite"] }],
      posted_at:            [->(h) { h["dates"]["posted"] }],
      taken_at:             [->(h) { h["dates"]["taken"] }],
      taken_at_granularity: [->(h) { h["dates"]["takengranularity"] }],
      updated_at:           [->(h) { h["dates"]["lastupdate"] }],
      views_count:          [->(h) { h["views"] }],
      public_editability:   [->(h) { h["publiceditability"] }],
      comments_count:       [->(h) { h["comments"] }],
      has_people?:          [->(h) { h["people"]["haspeople"] }],
      notes:                [->(h) { h["notes"]["note"] }],
      tags:                 [->(h) { h["tags"]["tag"].map { |hash| hash.merge("photo_id" => h["id"]) } }]
    }
  end
end
