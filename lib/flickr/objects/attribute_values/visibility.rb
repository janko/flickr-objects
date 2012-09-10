class Flickr
  class Visibility < Object
    self.attribute_values = {
      public?:  [->(h) { h["ispublic"] }],
      friends?: [->(h) { h["isfriend"] }],
      family?:  [->(h) { h["isfamily"] }]
    }
  end
end
