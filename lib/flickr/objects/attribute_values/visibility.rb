class Flickr
  class Visibility < Object
    self.attribute_values = {
      public?:   [->{ @hash["ispublic"] }],
      friends?:  [->{ @hash["isfriend"] }],
      family?:   [->{ @hash["isfamily"] }],
      contacts?: [->{ @hash["iscontact"] }],
    }
  end
end
