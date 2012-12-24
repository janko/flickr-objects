class Flickr
  class Set < Object
    self.attribute_values = {
      owner:          [-> { {"id" => @hash.fetch("owner"), "username" => @hash["username"]} }],
      url:            [-> { "http://www.flickr.com/photos/#{owner.id}/sets/#{id}/" }],
      photos_count:   [-> { @hash["photos"] }, -> { @hash["count_photos"] }],
      views_count:    [-> { @hash["count_views"] }],
      comments_count: [-> { @hash["count_comments"] }],
      title:          [-> { @hash["title"]["_content"] }],
      description:    [-> { @hash["description"]["_content"] }],
      permissions:    [-> { @hash.slice("can_comment") }],
      created_at:     [-> { @hash["date_create"] }],
      updated_at:     [-> { @hash["date_update"] }],
      primary_photo:  [-> { {"id" => @hash.fetch("primary")} }],
    }
  end
end
