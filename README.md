# Flickr Objects

This gem is an object-oriented wrapper for the [Flickr API](http://flickr.com/api).

- Web page: [http://janko.github.com/flickr-objects](http://janko.github.com/flickr-objects)
- Source code: [https://github.com/janko/flickr-objects](https://github.com/janko/flickr-objects)
- API Documentation: [http://rubydoc.info/github/janko/flickr-objects/master/frames](http://rubydoc.info/github/janko/flickr-objects/master/frames)

The gem has been tested on the following Ruby versions:

- MRI 1.9.3
- MRI 2.0
- MRI 2.1

## Installation and setup

Add it to your `Gemfile`, and run `bundle install`.

```ruby
gem "flickr-objects"
```

Now create an initializer where you set your Flickr credentials.

```ruby
Flickr.configure do |config|
  config.api_key       = "API_KEY"
  config.shared_secret = "SHARED_SECRET"
end
```

If you don't have them yet, you can apply for them
[here](http://www.flickr.com/services/apps/create/apply).

For list of possible configuration options, see
[`Flickr::Configuration`](http://rubydoc.info/github/janko/flickr-objects/master/Flickr/Configuration).

## Usage

This gem maps [Flickr's API methods](http://flickr.com/api) to Ruby methods.

```ruby
Flickr.photos.search(...)   # flickr.photos.search
Flickr.person.get_sets(...) # flickr.photosets.getList
```

For the list of all API methods (and their related Flickr's methods), see
[`Flickr::Api`](http://rubydoc.info/github/janko/flickr-objects/master/Flickr/Api).
These methods are included to the `Flickr` module.

Example:

```ruby
photos = Flickr.photos.search(user_id: "78733179@N04") #=> [#<Flickr::Object::Photo: ...>, #<Flickr::Object::Photo: ...>, ...]

photo = photos.first
photo.id                 #=> "231233252"
photo.title              #=> "My cat"
photo.visibility.public? #=> true

person = Flickr.people.find("78733179@N04")
set = person.sets.first
set.id           #=> "11243423"
set.photos_count #=> 40
```

Few notes here:

- flickr-objects distinguishes **instance** from **class** API methods. So,
  `Flickr.photos.search` is a **class** API method. And `Flickr.people.get_sets`
  is by its nature an **instance** API method, because we're finding sets
  *from a person*; in that case it's nicer to call `#get_sets` on an instance of
  person.
- Flickr objects can always be instantiated with `Flickr.<objects>.find(id)`
  (in the above example we did `Flickr.people.find(id)`).

## Arguments to API methods

By its nature, API methods always accept a hash of parameters. Using that approach,
this would be the call for "flickr.people.findByEmail":

```ruby
Flickr.people.find_by_email(find_email: "janko.marohnic@gmail.com")
```

But that looks lame. Luckily, in these kind of methods flickr-objects improves
the argument list:

```ruby
Flickr.people.find_by_email("janko.marohnic@gmail.com")
```

These arguments are documented:
[`Flickr::Api::Person#find_by_email`](http://rubydoc.info/github/janko/flickr-objects/master/Flickr/Api/Person#find_by_email-instance_method).

## Sizes

```ruby
person = Flickr.person.find("78733179@N04")
photo = person.public_photos(sizes: true).first

photo.small!(320)
photo.source_url #=> "http://farm9.staticflickr.com/8191/8130464513_780e01decd_n.jpg"
photo.width      #=> 320
photo.height     #=> 280

photo.medium!(500)
photo.width      #=> 500
```

It is important here that you pass `sizes: true` to `Flickr::Person#public_photos`.
So, in your (Rails) application, you could use it like this:

```ruby
class PhotosController < ApplicationController
  def index
    person = Flickr.people.find("78733179@N04")
    @photos = person.public_photos(sizes: true).map(&:medium500!)
  end
end
```
```erb
<% @photos.each do |photo| %>
  <%= image_tag photo.source_url, size: "#{photo.width}x#{photo.height}" %>
<% end %>
```

To find out more, see [`Flickr::Object::Photo`](http://rubydoc.info/github/janko/flickr-objects/master/Flickr/Object/Photo).

## Authentication

You may need to make authenticated API requests, using an access token.

```ruby
flickr = Flickr.new("ACCESS_TOKEN_KEY", "ACCESS_TOKEN_SECRET")

# It has the same interface as `Flickr`
flickr.test_login #=> {"id" => "78733179@N04", "username" => ...}
flickr.people.find("78733179@N04").get_photos #=> [#<Flickr::Photo ...>, #<Flickr::Photo, ...>, ...]
```

For details on how to authenticate the user, that is, obtain his access token, see
[`Flickr::OAuth`](http://rubydoc.info/github/janko/flickr-objects/master/Flickr/OAuth).

If you want, you can also assign the access token globally in your configuration.

```ruby
Flickr.configure do |config|
  config.access_token_key = "ACCESS_TOKEN_KEY"
  config.access_token_secret = "ACCESS_TOKEN_SECRET"
end
```

Naturally, this way you don't need to create an instance like above.

## Upload

```ruby
photo_id = Flickr.upload("/path/to/photo.jpg", title: "Dandelions")
photo = Flickr.photos.find(photo_id).get_info!
photo.title #=> "Dandelions"
```

See [`Flickr.upload`](http://rubydoc.info/github/janko/flickr-objects/master/Flickr/Api/General#upload-instance_method).

## Pagination

```ruby
Flickr.configure do |config|
  config.pagination = :will_paginate
end
```
```ruby
@photos = Flickr.photos.search(user_id: "78733179@N04", page: params[:page], per_page: 10)
```
```erb
<%= will_paginate @photos %>
```

Flickr gives you pagination on almost every request that returns a collection of objects.
This gem supports both [WillPaginate](https://github.com/mislav/will_paginate) (`:will_paginate`)
and [Kaminari](https://github.com/amatsuda/kaminari) (`:kaminari`).

## Caching

To enable caching responses, just pass in a cache object (an object that responds
to `#read`, `#write` and `#fetch`) in the configuration.

```ruby
require "active_support/cache"
require "active_support/core_ext/numeric/time"

Flickr.configure do |config|
  config.cache = ActiveSupport::Cache::MemoryStore(expires_in: 1.week)
end
```

```ruby
Flickr.photos.recent # Makes an API call
Flickr.photos.recent # Uses the cache
```

## Few words

Many of the API methods are not covered yet (because they are so many).
I believe I covered all the important ones, but if you wish for me to
cover certain new ones, feel free to contact me via [Twitter](https://twitter.com/jankomarohnic).
I also wouldn't mind getting a pull request ;)

## Social

You can follow me on Twitter, I'm [@jankomarohnic](https://twitter.com/jankomarohnic).

## License

This project is released under the [MIT license](LICENSE).
