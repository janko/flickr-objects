class Flickr
  class Collection < Array
    self.attribute_values = {
      current_page:  [->{ @hash.fetch("page") }],
      per_page:      [->{ @hash.fetch("per_page") }, ->{ @hash.fetch("perpage") }],
      total_entries: [->{ @hash.fetch("total") }],
      total_pages:   [->{ @hash.fetch("pages") }],
    }
  end
end
