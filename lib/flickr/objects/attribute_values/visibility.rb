class Flickr
  class Visibility < Object
    self.attribute_values = {
      public?:   [proc { @hash.fetch("ispublic") }],
      friends?:  [proc { @hash.fetch("isfriend") }],
      family?:   [proc { @hash.fetch("isfamily") }],
      contacts?: [proc { @hash.fetch("iscontact") }]
    }
  end
end
