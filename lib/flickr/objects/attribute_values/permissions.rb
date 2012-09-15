class Flickr
  class Permissions < Object
    self.attribute_values = {
      can_comment?:  [proc { @hash.fetch("cancomment") }],
      can_add_meta?: [proc { @hash.fetch("canaddmeta") }],
      can_download?: [proc { @hash.fetch("candownload") }],
      can_blog?:     [proc { @hash.fetch("canblog") }],
      can_print?:    [proc { @hash.fetch("canprint") }],
      can_share?:    [proc { @hash.fetch("canshare") }]
    }
  end
end
