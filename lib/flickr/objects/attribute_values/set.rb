class Flickr
  class Set < Object
    self.attribute_values = {
      owner:            [-> { {"id" => @hash.fetch("owner"), "username" => @hash["username"]} }],
      url:              [-> { "http://www.flickr.com/photos/#{owner.id}/sets/#{id}/" }],
      media_count:      [-> { @hash["photos"] }],
      views_count:      [-> { @hash["count_views"] }],
      comments_count:   [-> { @hash["count_comments"] }],
      photos_count:     [-> { @hash["count_photos"] }, -> { @hash["photos"] }],
      videos_count:     [-> { @hash["count_videos"] }, -> { @hash["videos"] }],
      title:            [-> { @hash["title"]["_content"] }],
      description:      [-> { @hash["description"]["_content"] }],
      permissions:      [-> { @hash.slice("can_comment") }],
      created_at:       [-> { @hash["date_create"] }],
      updated_at:       [-> { @hash["date_update"] }],
      primary_media_id: [-> { @hash["primary"] }],
      primary_photo:    [-> { {"id" => @hash.fetch("primary")} }],
      primary_video:    [-> { {"id" => @hash.fetch("primary")} }],
    }
  end
end
