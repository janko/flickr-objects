# Flickr Objects

This gem is an object-oriented wrapper for the [Flickr API](http://flickr.com/api).
To see its capability, take a look at this nice demonstration:

[http://janko-m.github.com/flickr-objects/](http://janko-m.github.com/flickr-objects/)

## Installation and setup

Add it to your `Gemfile`, and run `bundle install`.

```ruby
gem "flickr-objects"
```

Now create an initializer where you set your Flickr credentials.

```ruby
Flickr.configure do |config|
  config.api_key = "API_KEY"
  config.shared_secret = "SHARED_SECRET"
end
```

If you don't have them yet, you can apply for them [here](http://www.flickr.com/services/apps/create/apply).

For list of possible configuration options, take a look at [this
wiki](https://github.com/janko-m/flickr-objects/wiki/Configuration).

## Usage

This gem maps [Flickr's API methods](http://flickr.com/api) to methods on objects.
A handy reference for those mappings is in `Flickr.api_methods`:

```ruby
Flickr.api_methods["flickr.photos.search"]     #=> ["Flickr::Photo.search"]
Flickr.api_methods["flickr.photosets.getList"] #=> ["Flickr::Person#get_sets"]
```

As you see, sometimes names can differ, but you can always find out this way.
So, `Flickr::Photo.search` is a **class** API method, and
`Flickr::Person#get_sets` is an **instance** API method.

Here's an example:

```ruby
photos = Flickr.photos.search(user_id: "78733179@N04") #=> [#<Flickr::Photo: ...>, #<Flickr::Photo: ...>, ...]

photo = photos.first
photo.id                 #=> "231233252"
photo.title              #=> "My cat"
photo.visibility.public? #=> true

person = Flickr.people.find("78733179@N04")
sets = person.get_sets #=> [#<Flickr::Set: ...>, #<Flickr::Set: ...>, ...]

set = sets.first
set.id           #=> "11243423"
set.photos_count #=> 40
```

You can always manually instantiate objects with `Flickr.objects.find(id)`
(in the above example we called `Flickr.people.find(id)`).

Parameters to API methods are not always passed as a hash. For example, instead
of calling "flickr.people.findByEmail" like this:

```ruby
Flickr.people.find_by_email(find_email: "janko.marohnic@gmail.com")
```

this gem has the convention of calling it like this:

```ruby
Flickr.people.find_by_email("janko.marohnic@gmail.com")
```

This is always the case with required parameters. You can still pass a hash of
other parameters as the last argument.

For documentation on valid arguments, just look at the source code under
[`lib/flickr/api`](https://github.com/janko-m/flickr-objects/tree/master/lib/flickr/api).
There you will find listed all the API methods of a specific object.

## Sizes

```ruby
person = Flickr.person.find(person_id)
photo = person.get_public_photos(sizes: :all).first

photo.small!(320)
photo.source_url #=> "http://farm9.staticflickr.com/8191/8130464513_780e01decd_n.jpg"
photo.width      #=> 320
photo.height     #=> 280

photo.medium!(500)
photo.width      #=> 500
```

It is important here that you pass `sizes: :all` to `Flickr::Person#get_public_photos`.
So, in your (Rails) application, one could use it like this:

```ruby
class PhotosController < ApplicationController
  def index
    person = Flickr.people.find("78733179@N04")
    @photos = person.get_public_photos(sizes: :all).map { |photo| photo.medium!(500) }
  end
end
```
```erb
<% @photos.each do |photo| %>
  <%= image_tag photo.source_url, size: "#{photo.width}x#{photo.height}" %>
<% end %>
```

To find out more, take a look at [this wiki](https://github.com/janko-m/flickr-objects/wiki/Sizes).

## Authentication

If you need to make authenticated API requests (which you'll probably often want), you should create an
instance, assigning it the user's access token.

```ruby
flickr = Flickr.new("ACCESS_TOKEN_KEY", "ACCESS_TOKEN_SECRET")

# It has the same interface as `Flickr`
flickr.test_login #=> {"id" => "78733179@N04", "username" => ...}
flickr.people.find("78733179@N04").get_photos #=> [#<Flickr::Photo ...>, #<Flickr::Photo, ...>, ...]
```

For details on how to authenticate (obtain the access token) take a look at
[this wiki](http://github.com/janko-m/flickr-objects/wiki/Authentication).

You can also assign the access token globally in your configuration.

```ruby
Flickr.configure do |config|
  config.access_token_key = "ACCESS_TOKEN_KEY"
  config.access_token_secret = "ACCESS_TOKEN_SECRET"
end
```

## Upload

```ruby
photo_id = Flickr.upload("/path/to/photo.jpg", title: "Dandelions")
photo = Flickr.photos.find(photo_id).get_info!
photo.title #=> "Dandelions"
```

In the first argument you can pass in either a string (path to the file) or an open file.
For the details on the additional options you can pass in, check out Flickr's [upload
documentation](http://www.flickr.com/services/api/upload.api.html).

For asynchronous upload take a look at [this wiki](https://github.com/janko-m/flickr-objects/wiki/Upload).

## Attributes and methods

For the list of attributes and methods that Flickr objects have, the best place to look at
is the source code. The source code is written in such a simple way that it acts as its
own documentation, so don't be discouraged if you haven't had experience in looking into other
people's code yet :)

For example, list of `Flickr::Photo`'s attributes can be found in
[`lib/flickr/objects/photo.rb`](https://github.com/janko-m/flickr-objects/blob/master/lib/flickr/objects/photo.rb).
Take a look just to see how it looks like :)

## Few words

Most of the API methods are not covered yet (because they are so many). I will
be covering new ones regularly.

Feel free to speed up covering certain API methods by contacting me through
[Twitter](https://twitter.com/m_janko). Pull requests are also very welcome :)

## Social

You can follow me on Twitter, I'm [@m_janko](https://twitter.com/m_janko).

## License

This project is released under the [MIT license](https://github.com/janko-m/flickr-objects/blob/master/LICENSE).
