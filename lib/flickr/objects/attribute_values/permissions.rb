class Flickr
  class Permissions < Object
    self.attribute_values = {
      can_comment?:  [proc {|hash| hash.fetch("cancomment") }],
      can_add_meta?: [proc {|hash| hash.fetch("canaddmeta") }],
      can_download?: [proc {|hash| hash.fetch("candownload") }],
      can_blog?:     [proc {|hash| hash.fetch("canblog") }],
      can_print?:    [proc {|hash| hash.fetch("canprint") }],
      can_share?:    [proc {|hash| hash.fetch("canshare") }]
    }
  end
end
