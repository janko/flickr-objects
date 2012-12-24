class Flickr
  class List < Object
    self.attribute_values = {
      current_page:  [->{ @hash["page"] }],
      per_page:      [->{ @hash["per_page"] }, ->{ @hash["perpage"] }],
      total_entries: [->{ @hash["total"] }],
      total_pages:   [->{ @hash["pages"] }],
    }
  end
end
