class Flickr
  class Visibility < Object
    self.attribute_values = {
      public?:   [->{ @hash.fetch("ispublic") }],
      friends?:  [->{ @hash.fetch("isfriend") }],
      family?:   [->{ @hash.fetch("isfamily") }],
      contacts?: [->{ @hash.fetch("iscontact") }]
    }
  end
end
