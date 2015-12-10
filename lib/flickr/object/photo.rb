module Flickr
  class Object

    ##
    # Probably the most important class in this library.
    #
    # ## Sizes
    #
    # It has an interface for assigning the photo's size. Current Flickr's photo sizes
    # are:
    #
    # - Square 75/150
    # - Thumbnail
    # - Medium 500/640/800
    # - Large 1024/1600/2048
    # - Original
    #
    # **Important**: When fetching photos, the information about the sizes (URL, width, height)
    # isn't automatically available. If you're fetching multiple photos (e.g. using
    # `Flickr.photos.search`), you need to pass `:sizes => true`. For individual photos,
    # use #get_sizes.
    #
    # Any of the following ways will change the photo's size to "Medium 500":
    #
    #     photo.medium500!
    #     photo.medium!(500)
    #     photo.medium!("500")
    #
    # A change to photo's size affects the following attributes: {#source_url}, {#width} and
    # {#height}.
    #
    # You may often just want to assign the largest possible size to the photo:
    #
    #     photo.largest!
    #
    # You may also want to assign the largest size to the photo, but that it's not
    # larger/smaller than "Medium 500":
    #
    #     photo.medium500_or_smaller!
    #     photo.medium500_at_least!
    #
    # Note: The corresponding non-bang versions of the methods are also available:
    #
    #     photo.medium500
    #     photo.medium(500)
    #     photo.medium("500")
    #     photo.largest
    #     photo.medium500_or_smaller
    #     photo.medium500_at_least
    #
    # However, these are not recommended, since they duplicate the photo, taking up
    # twice as much memory. Use them only if you really have to.
    #
    class Photo < Flickr::Object

      autoload_names :Note, :Tag, :Exif, :Size

      attribute :id,                   String
      attribute :secret,               String
      attribute :server,               String
      attribute :farm,                 Integer
      attribute :title,                String
      attribute :description,          String
      attribute :license,              Integer
      attribute :visibility,           Visibility

      attribute :safety_level,         Integer
      attribute :safe,                 Boolean
      attribute :moderate,             Boolean
      attribute :restricted,           Boolean

      attribute :url,                  String
      attribute :short_url,            String

      attribute :owner,                Person

      attribute :uploaded_at,          Time
      attribute :posted_at,            Time
      attribute :taken_at,             Time
      attribute :taken_at_granularity, Integer
      attribute :updated_at,           Time

      attribute :views_count,          Integer
      attribute :comments_count,       Integer

      attribute :editability,          Permissions
      attribute :public_editability,   Permissions
      attribute :usage,                Permissions

      attribute :notes,                List[Note]
      attribute :tags,                 List[Tag]

      attribute :camera,               String
      attribute :exif,                 Exif

      attribute :has_people,           Boolean
      attribute :favorite,             Boolean

      attribute :path_alias,           String

      attribute :location,             Location
      attribute :location_visibility,  Visibility

      attribute :rotation,             Integer

      attribute :available_sizes,      Array[String]
      attribute :largest_size,         String

      attribute :source_url,           String
      attribute :height,               Integer
      attribute :width,                Integer

      SIZES = [
        "Square 75", "Thumbnail", "Square 150",
        "Small 240", "Small 320",
        "Medium 500", "Medium 640", "Medium 800",
        "Large 1024", "Large 1600", "Large 2048",
        "Original",
      ]

      ##
      # The size of the photo, can be changed with modifer methods (see the
      # definition of this class for details).
      #
      # @return [String]
      #
      def size
        @size.name if @size
      end

      Size.all.each do |size|
        type, number = size.type, size.number

        ##
        # medium500!
        # medium500
        #
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{type.downcase}#{number}!
            size! "#{size.name}"
          end

          def #{type.downcase}#{number}
            dup.#{type.downcase}#{number}!
          end
        RUBY
      end

      Size.types.each do |type|
        ##
        # medium!(500)
        # medium(500)
        #
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{type.downcase}!(number = nil)
            size! (number ? "#{type} \#{number}" : "#{type}")
          end

          def #{type.downcase}(number = nil)
            dup.#{type.downcase}!(number)
          end
        RUBY
      end

      Size.all.each do |size|
        type, number = size.type, size.number

        ##
        # medium500_or_smaller
        # medium500_or_smaller!
        #
        # medium500_at_least
        # medium500_at_least!
        #
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{type.downcase}#{number}_or_smaller!
            upper_bound = "#{size.name}"
            new_size = available_sizes.reverse.find do |name|
              Size.new(name) <= Size.new(upper_bound)
            end
            size! new_size
          end

          def #{type.downcase}#{number}_or_smaller
            dup.#{type.downcase}#{number}_or_smaller!
          end

          def #{type.downcase}#{number}_at_least!
            lower_bound = "#{size.name}"
            new_size = available_sizes.reverse.find do |name|
              Size.new(name) >= Size.new(lower_bound)
            end
            size! new_size
          end

          def #{type.downcase}#{number}_at_least
            dup.#{type.downcase}#{number}_at_least!
          end
        RUBY
      end

      ##
      # @return [self]
      #
      def largest!
        size! largest_size
      end

      ##
      # @return [self]
      #
      def largest
        dup.largest!
      end

      ##
      # Changes the size of the photo.
      #
      def size!(name)
        if name != nil and not Size.exists?(name)
          raise ArgumentError, "\"#{name}\" isn't a valid photo size"
        end

        @size = Size.new(name)

        self
      end

      ##
      # @return [self]
      # @see Flickr::Api::Photo#get_info
      #
      def get_info!(params = {})
        photo = api.get_info(id, params)
        update(photo.attributes)
      end

      ##
      # @return [self]
      # @see Flickr::Api::Photo#get_sizes
      #
      def get_sizes!(params = {})
        photo = api.get_sizes(id, params)
        update(photo.attributes)
      end

      ##
      # @return [self]
      # @see Flickr::Api::Photo#get_exif
      #
      def get_exif!(params = {})
        photo = api.get_exif(id, params)
        update(photo.attributes)
      end

      ##
      # @return [Flickr::Object::List<Flickr::Object::Person>]
      # @see Flickr::Api::Photo#get_favorites
      #
      def get_favorites(params = {})
        api.get_favorites(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#delete
      #
      def delete(params = {})
        api.delete(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#set_content_type
      #
      def set_content_type(content_type, params = {})
        api.set_content_type(id, content_type, params)
      end
      alias content_type= set_content_type

      ##
      # @return [response]
      # @see Flickr::Api::Photo#set_tags
      #
      def set_tags(tags, params = {})
        api.set_tags(id, tags, params)
      end
      alias tags= set_tags

      ##
      # @return [response]
      # @see Flickr::Api::Photo#add_tags
      #
      def add_tags(tags, params = {})
        api.add_tags(id, tags, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#remove_tag
      #
      def remove_tag(tag_or_id, params = {})
        api.remove_tag(id, tag_or_id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#set_dates
      #
      def set_dates(params = {})
        api.set_dates(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#set_meta
      #
      def set_meta(params = {})
        api.set_meta(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#set_permissions
      #
      def set_permissions(params = {})
        api.set_permissions(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#set_safety_level
      #
      def set_safety_level(params = {})
        api.set_safety_level(id, params)
      end

      ##
      # @return [response]
      # @see Flickr::Api::Photo#set_license
      #
      def set_license(license_id, params = {})
        api.set_license(id, license_id, params)
      end

    end

  end
end

require_relative "attribute_locations/photo"
