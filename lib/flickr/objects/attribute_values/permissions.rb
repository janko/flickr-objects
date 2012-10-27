class Flickr
  class Permissions < Object
    self.attribute_values = {
      can_comment?:  [->{ @hash.fetch("cancomment") }, ->{ @hash.fetch("can_comment") }],
      can_add_meta?: [->{ @hash.fetch("canaddmeta") }],
      can_download?: [->{ @hash.fetch("candownload") }],
      can_blog?:     [->{ @hash.fetch("canblog") }],
      can_print?:    [->{ @hash.fetch("canprint") }],
      can_share?:    [->{ @hash.fetch("canshare") }],
    }
  end
end
