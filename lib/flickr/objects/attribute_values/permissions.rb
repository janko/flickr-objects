class Flickr
  class Permissions < Object
    self.attribute_values = {
      can_comment?:  [->{ @hash["cancomment"] }, ->{ @hash["can_comment"] }],
      can_add_meta?: [->{ @hash["canaddmeta"] }],
      can_download?: [->{ @hash["candownload"] }],
      can_blog?:     [->{ @hash["canblog"] }],
      can_print?:    [->{ @hash["canprint"] }],
      can_share?:    [->{ @hash["canshare"] }],
    }
  end
end
