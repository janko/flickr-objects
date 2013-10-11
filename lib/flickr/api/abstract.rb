module Flickr
  module Api

    ##
    # This class abstracts the interface for communication with the Flickr API.
    #
    # @see Flickr::ApiError
    # @see Flickr::OAuthError
    # @see Flickr::TimeoutError
    #
    class Abstract

      extend Flickr::AutoloadHelper

      autoload_names :ParamsProcessor

      ##
      # @private
      #
      def self.object_class
        Flickr::Object.const_get(name.match(/^Flickr::Api::/).post_match)
      end

      ##
      # @private
      #
      def initialize(access_token = nil)
        @access_token = access_token
      end

      ##
      # @param id [String] ID of the object to be instantiated
      # @example
      #   person = Flickr.photos.find("1")
      #   person.photos.each do |photo|
      #     # ...
      #   end
      #
      def find(id)
        object_class = self.class.object_class
        object_class.new({"id" => id}, @access_token)
      end

      private

      def get(flickr_method, params = {})
        make_request(:get, flickr_method, params)
      end

      def post(flickr_method, params = {})
        make_request(:post, flickr_method, params)
      end

      def make_request(http_method, flickr_method, params = {})
        process_params(params, flickr_method)
        client[:data].send(http_method, "flickr.#{flickr_method}", params)
      end

      def upload(params = {})
        client[:upload].upload(params)
      end

      def replace(params = {})
        client[:upload].replace(params)
      end

      def client
        {
          data:   Flickr::Client::Data.new(@access_token),
          upload: Flickr::Client::Upload.new(@access_token),
        }
      end

      ##
      # Enhances params, allowing nicer syntax.
      #
      # @example
      #   params = {sizes: ["Thumbnail", "Medium 500"]}
      #   process_params(params, "flickr.photos.search")
      #   params #=> {extras: "url_t,url_m"}
      # @see Flickr::Api::Abstract::ParamsProcessor
      #
      def process_params(params, flickr_method)
        ParamsProcessor.new(params).process_for(flickr_method)
      end

      ##
      # @example
      #   photo = new_object(:Photo, {"id" => "1"})
      #   photo #=> #<Flickr::Object::Photo:0x007fcb9e08dee8 id="1">
      #
      def new_object(class_name, attributes)
        object_class = self.class.object_class.const_get(class_name)
        object_class.new(attributes, @access_token)
      end

      ##
      # @example
      #   photos = new_list(:Photo, [{"id" => "1"}], {"page" => 1})
      #   photos #=> #<Flickr::Object::List:0x007ffe6b51d468
      #          #   @attributes={"page"=>1},
      #          #   @objects=
      #          #    [#<Flickr::Object::Photo:0x007ffe6b4ff760 owner=#<Flickr::Object::Person:0x007ffe6b52d408 >>,
      #          #     #<Flickr::Object::Photo:0x007ffe6b4fdcd0 owner=#<Flickr::Object::Person:0x007ffe6b556ab0 >>]>
      #
      def new_list(class_name, attributes_list, list_attributes)
        objects = attributes_list.map { |attributes| new_object(class_name, attributes) }
        list = Flickr::Object::List.new(list_attributes)
        list.populate(objects)
      end

    end

  end
end
