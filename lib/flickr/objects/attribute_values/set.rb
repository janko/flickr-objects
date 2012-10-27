class Flickr
  class Set < Object
    self.attribute_values = {
      owner:            [-> { {"id" => @hash.fetch("owner"), "username" => @hash.fetch("username")} }],
      url:              [-> { "http://www.flickr.com/photos/#{owner.id}/sets/#{id}/" }],
      media_count:      [-> { @hash.fetch("photos") }],
      views_count:      [-> { @hash.fetch("count_views") }],
      comments_count:   [-> { @hash.fetch("count_comments") }],
      photos_count:     [-> { @hash.fetch("count_photos") }],
      videos_count:     [-> { @hash.fetch("count_videos") }],
      title:            [-> { @hash.fetch("title")["_content"] }],
      description:      [-> { @hash.fetch("description")["_content"] }],
      permissions:      [-> { @hash.slice("can_comment") }],
      created_at:       [-> { @hash.fetch("date_create") }],
      updated_at:       [-> { @hash.fetch("date_update") }],
      primary_media_id: [-> { @hash.fetch("primary") }],
      primary_photo:    [-> { {"id" => @hash.fetch("primary")} }],
      primary_video:    [-> { {"id" => @hash.fetch("primary")} }],
    }
  end
end
