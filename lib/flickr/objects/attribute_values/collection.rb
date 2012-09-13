class Flickr
  class Collection < Array
    self.attribute_values = {
      current_page:  [proc {|hash| hash.fetch("page") }],
      per_page:      [proc {|hash| hash.fetch("per_page") }, proc {|hash| hash.fetch("perpage") }],
      total_entries: [proc {|hash| hash.fetch("total") }],
      total_pages:   [proc {|hash| hash.fetch("pages") }]
    }
  end
end
