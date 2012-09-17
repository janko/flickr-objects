require "#{RSPEC_DIR}/credentials"

module RSpecHelpers
  def make_request(*args)
    method = args.shift
    VCR.use_cassette method do
      ACTIONS[method].call(*args)
    end
  end

  ACTIONS = {
    "flickr.photos.search"         => proc { |klass = Flickr::Media| klass.search(user_id: USER_ID, extras: EXTRAS) },
    "flickr.photos.getInfo"        => proc { |klass = Flickr::Media| klass.find(PHOTO_ID).get_info! },
    "flickr.nonExistingMethod"     => proc { Flickr.client.get "flickr.nonExistingMethod" },
    "flickr.test.echo"             => proc { Flickr.test_echo },
    "flickr.test.null"             => proc { Flickr.test_null },
    "flickr.test.login"            => proc { Flickr.test_login }
  }
end
