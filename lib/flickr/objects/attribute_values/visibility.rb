class Flickr
  class Visibility < Object
    self.attribute_values = {
      public?:  [proc {|hash| hash.fetch("ispublic") }],
      friends?: [proc {|hash| hash.fetch("isfriend") }],
      family?:  [proc {|hash| hash.fetch("isfamily") }]
    }
  end
end
