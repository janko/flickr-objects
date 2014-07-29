require "flickr/error"

module Flickr

  ##
  # @private
  #
  module AutoloadHelper
    def autoload_dir(directory, mappings)
      mappings.each do |const_name, path|
        autoload const_name, File.join(directory, path)
      end
    end

    ##
    # Flickr::Object and Flickr::Api contain too many constants, so rather than
    # providing an explicit filename we rather use the underscored constant name.
    #
    def autoload_names(*class_names)
      mappings = class_names.inject({}) do |mappings, class_name|
        mappings.update(class_name => Flickr.underscore(class_name.to_s))
      end
      directory = Flickr.underscore(name)

      autoload_dir directory, mappings
    end
  end

  extend AutoloadHelper

  autoload_dir "flickr",
    :Configuration => "configuration",
    :Api           => "api",
    :OAuth         => "oauth",
    :Object        => "object",
    :Client        => "client"

  ##
  # ActiveSupport's `underscore` (simpler version), used in
  # Flickr::AutoloadHelper#autoload_names
  #
  # @example
  #   Flickr.underscore("Foo::Bar::Baz") # => "foo/bar/baz"
  # @private
  #
  def self.underscore(class_name)
    class_name
      .split("::")
      .map { |s| s.split(/(?=[A-Z])/).map(&:downcase).join("_") }
      .join("/")
  end

  extend Flickr::Configuration

  ##
  # If you're obtaining the access token dynamically, then you can't set it in
  # the global configuration. This method allows you to create a temporary
  # instance with the access token.
  #
  # @example
  #   flickr = Flickr.new("KEY", "SECRET")
  #   flickr.photos.get_recent
  #   # ...
  # @return [Flickr]
  #
  def self.new(access_token_key, access_token_secret)
    dup.configure do |config|
      config.access_token_key    = access_token_key
      config.access_token_secret = access_token_secret
    end
  end

  extend Flickr::Api

  ##
  # @private
  #
  def self.deprecation_warn(message)
    warn "[FLICKR OBJECTS] #{message}"
  end

end
