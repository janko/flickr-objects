module Flickr

  ##
  # Provides general configuration options for the library.
  #
  module Configuration

    ##
    # @example
    #     Flickr.configure do |config|
    #       config.api_key = "..."
    #       config.shared_secret = "..."
    #       # ...
    #     end
    #
    def configure
      yield self
      self
    end

    ##
    # API key and shared secret are necessary for making API requests. You can apply
    # for them [here][api_key].
    #
    # [api_key]: http://www.flickr.com/services/apps/create/apply
    #
    attr_accessor :api_key, :shared_secret

    ##
    # Required for authenticated requests.
    #
    #     config.access_token_key    = "KEY"
    #     config.access_token_secret = "SECRET"
    #
    # For details on how to obtain it, take a look at the {Flickr::OAuth} module.
    #
    attr_accessor :access_token_key, :access_token_secret

    ##
    # @return [Array(string, string)]
    # @private
    #
    def access_token
      if access_token_key and access_token_secret
        [access_token_key, access_token_secret]
      end
    end

    ##
    # Time to wait for the connection to Flickr to open. After that
    # {Flickr::TimeoutError} is thrown.
    #
    # Default is `5` seconds.
    #
    attr_accessor :open_timeout
    ##
    # Time to wait for the first block of response from Flickr. After that
    # {Flickr::TimeoutError} is thrown.
    #
    # Default is `10` seconds.
    #
    attr_accessor :timeout

    ##
    # You can choose to make requests over a secure connection (SSL).
    #
    #     config.use_ssl = true
    #
    # Default is `false`.
    #
    attr_accessor :use_ssl
    alias secure= use_ssl=

    ##
    # You can choose to go over a proxy.
    #
    #     config.proxy = "http://proxy.com"
    #
    attr_accessor :proxy

    ##
    # When retrieving photos from Flickr, you can enable automatic compatibility
    # with a pagination library.
    #
    #     config.pagination = :will_paginate
    #
    # Supports [WillPaginate][will_paginate] and [Kaminari][kaminari].
    #
    # [will_paginate]: https://github.com/mislav/will_paginate
    # [kaminari]: https://github.com/amatsuda/kaminari
    #
    attr_accessor :pagination

    ##
    # Enables caching responses. An object that is passed must respond to
    # `#read`, `#write` and `#fetch`.
    #
    #     config.cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 1.hour)
    #
    attr_accessor :cache

  end

end
