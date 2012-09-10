class Flickr
  class Permissions < Object
    self.attribute_values = {
      can_comment?:  [->(h) { h["cancomment"] }],
      can_add_meta?: [->(h) { h["canaddmeta"] }],
      can_download?: [->(h) { h["candownload"] }],
      can_blog?:     [->(h) { h["canblog"] }],
      can_print?:    [->(h) { h["canprint"] }],
      can_share?:    [->(h) { h["canshare"] }]
    }
  end
end
