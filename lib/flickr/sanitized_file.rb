require "delegate"

module Flickr

  ##
  # File that users provide for uploading can come from various sources (Rails, Sinatra
  # etc). This class attempts to sanitize it, pulling out the path, content type,
  # and the actual file.
  #
  # @private
  #
  class SanitizedFile < SimpleDelegator

    attr_reader :file, :content_type, :path

    ##
    # @param original [String, File, Rails, Sinatra]
    #
    def initialize(original)
      @original = original
      sanitize!
      super(@file)
    end

    private

    ##
    # Extracts the tempfile, content type and path.
    #
    def sanitize!
      if rails_file?
        @file = @original
        @content_type = @original.content_type
        @path = @original.tempfile
      elsif sinatra_file?
        @file = @original[:tempfile]
        @content_type = @original[:type]
        @path = @original[:tempfile].path
      elsif file?
        @file = @original
        @content_type = @original.content_type if @original.respond_to?(:content_type)
        @path = @original.path
      elsif string?
        @file = File.open(@original)
        @content_type = nil
        @path = @original
      else
        raise ArgumentError, "invalid file format"
      end
    end

    def rails_file?
      defined?(Rails) and @original.is_a?(ActionDispatch::Http::UploadedFile)
    end

    def sinatra_file?
      defined?(Sinatra) and @original.is_a?(Hash)
    end

    def file?
      @original.respond_to?(:read) and @original.respond_to?(:path)
    end

    def string?
      @original.is_a?(String)
    end

  end

end
