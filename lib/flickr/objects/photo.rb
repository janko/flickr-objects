class Flickr
  class Photo < Media

    attribute :rotation,   Integer

    attribute :source_url, String
    attribute :height,     Integer
    attribute :width,      Integer

    # This creates size methods. For example:
    #
    #   small_photo = photo.square150
    #   small_photo.size #=> "Square 150"
    #   small_photo.source_url #=> URL to the "Square 150" version
    #
    # You can also put the number in the parameter, if you like that version better:
    #
    #   photo.square(150)
    #   photo.square("150")
    #
    # You also get the bang versions, which change the receiver:
    #
    #   photo.square150!
    #   photo.square!(150)
    #
    SIZES.keys.each do |size|
      size_name, size_number = size.split(" ").map(&:downcase)

      define_method("#{size_name}#{size_number}!") { @size = size; self }
      define_method("#{size_name}#{size_number}")  { dup.send("#{size_name}#{size_number}!") }

      if size_number
        define_method("#{size_name}!") {|size_number| send("#{size_name}#{size_number}!") }
        define_method("#{size_name}")  {|size_number| send("#{size_name}#{size_number}") }
      end
    end

    def size
      @size
    end

    def largest!; @size = largest_size; self end
    def largest;  dup.largest!               end
  end
end
