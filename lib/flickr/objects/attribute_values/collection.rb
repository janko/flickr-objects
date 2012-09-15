class Flickr
  class Collection < Array
    self.attribute_values = {
      current_page:  [proc { @hash.fetch("page") }],
      per_page:      [proc { @hash.fetch("per_page") }, proc { @hash.fetch("perpage") }],
      total_entries: [proc { @hash.fetch("total") }],
      total_pages:   [proc { @hash.fetch("pages") }]
    }
  end
end
