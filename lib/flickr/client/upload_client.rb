class Flickr
  class UploadClient < Client
    def initialize(access_token)
      super(access_token) do |builder|
        builder.use Faraday::Request::Multipart
      end
    end

    def upload(media, params = {})
      file = get_file(media)
      response = post "upload", {photo: file}.merge(params)
      response.body
    end

    def replace(media, id, params = {})
      file = get_file(media)
      response = post "replace", {photo: file, photo_id: id}.merge(params)
      response.body
    end

    def parser
      FaradayMiddleware::ParseXml
    end

    private

    def get_file(object)
      file, content_type, file_path =
        if object.is_a?(String)
          [File.open(object), determine_content_type(object), object]
        elsif object.class.name == "ActionDispatch::Http::UploadedFile"
          [object, object.content_type, object.tempfile]
        elsif object.respond_to?(:read) and object.respond_to?(:path)
          [object, (object.respond_to?(:content_type) && object.content_type) || determine_content_type(object.path), object.path]
        elsif object.is_a?(Hash) && defined?(Sinatra)
          [object[:tempfile], object[:type], object[:tempfile].path]
        else
          raise Error, "invalid file format"
        end

      Faraday::UploadIO.new(file, content_type, file_path)
    end

    def determine_content_type(path)
      extension = File.extname(path)
      array = CONTENT_TYPES.keys.find { |array| array.include?(extension) }

      if array
        CONTENT_TYPES[array]
      else
        raise Error, "content type for #{extension} is not known"
      end
    end

    CONTENT_TYPES = {
      %w[.jpg .jpeg .jpe .jif .jfif .jfi] => 'image/jpeg',
      %w[.gif]                            => 'image/gif',
      %w[.png]                            => 'image/png',
      %w[.svg .svgz]                      => 'image/svg+xml',
      %w[.tiff .tif]                      => 'image/tiff',
      %w[.ico]                            => 'image/vnd.microsoft.icon',

      %w[.mpg .mpeg .m1v .m1a .m2a .mpa .mpv] => 'video/mpeg',
      %w[.mp4 .m4a .m4p .m4b .m4r .m4v]       => 'video/mp4',
      %w[.ogv .oga .ogx .ogg .spx]            => 'video/ogg',
      %w[.mov .qt]                            => 'video/quicktime',
      %w[.webm]                               => 'video/webm',
      %w[.mkv .mk3d .mka .mks]                => 'video/x-matroska',
      %w[.wmv]                                => 'video/x-ms-wmv',
      %w[.flv .f4v .f4p .f4a .f4b]            => 'video/x-flv',
      %w[.avi]                                => 'video/avi'
    }
  end
end
