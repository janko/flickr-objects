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

If you don't have your API key and shared secret yet, you can apply for them
[here](http://www.flickr.com/services/apps/create/apply).

## Usage

Let's start with a general example.

```ruby
photos = Flickr.photos.search(user_id: "78733179@N04") #=> [#<Flickr::Photo: ...>, #<Flickr::Photo: ...>, ...]

photo = photos.first
photo.id                  #=> "231233252"
photo.title               #=> "My cat"
photo.visibility.public?  #=> true
photo.tags = "cats funny" # API request
photo.get_info!           # API request
photo.tags.join(" ")      #=> "cats funny"
```

Methods like `Flickr.photos.search` are **class** API methods, and methods like `photo.tags=` and
`photo.get_info!` are **instance** API methods.

- `Flickr.photos.search` <=> `Flickr::Photo.search`
- `photo.tags=`          <=> `Flickr::Photo#tags=`
- `photo.get_info!`      <=> `Flickr::Photo#get_info!`

API methods under the hood call methods described on Flickr's official [API page](http://flickr.com/api).
In our example, we have this correspondence:

- `Flickr::Photo.search`    <=> flickr.photos.search
- `Flickr::Photo#tags=`     <=> flickr.photos.setTags
- `Flickr::Photo#get_info!` <=> flickr.photos.getInfo

Raw Flickr's API methods always take a hash of parameters. So, for example,
flickr.people.findByEmail takes the `:find_email` parameter. But this gem
implies these kind of obvious parameters, so instead of having to call it like this:

```ruby
Flickr.people.find_by_email(find_email: "janko.marohnic@gmail.com")
```

you can rather call it like this:

```ruby
Flickr.people.find_by_email("janko.marohnic@gmail.com")
```

You can still pass a hash of other parameters as the last argument. For the
documentation on valid arguments, just look at the source code under
`lib/flickr/api/`. In our example, because `.find_by_email` belongs to `people`,
the method is located in [`lib/flickr/api/person.rb`](https://github.com/janko-m/flickr-objects/blob/master/lib/flickr/api/person.rb#L3-6).

Now, let's say that you want to use a method that fetches all sets from a
person. And you find out that this method is "flickr.photosets.getList".
How can you now find out where it is located in this gem? Well, that's where
`Flickr.api_methods` comes in handy. You can call it in the console:

```ruby
Flickr.api_methods["flickr.photosets.getList"] #=> ["Flickr::Person#get_sets"]
```

Now you found out that it is located in `Flickr::Person#get_sets`.

```ruby
# You can now call it like this:
sets = Flickr.people.find(person_id).get_sets
sets.first.id #=> "12312324"

# Or like this:
sets = Flickr.find_by_username("josh").get_sets
sets.first.id #=> "12312324"
```

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
own documentation, so don't worry if you haven't had experience in looking into other
people's code :)

For example, list of common attributes that `Flickr::Photo`
and `Flickr::Video` have can be found in [`lib/flickr/objects/media.rb`]("https://github.com/janko-m/flickr-objects/blob/master/lib/flickr/objects/media.rb").
Take a look just to see how it looks like :)

## Few words

Most of the API methods are not covered yet (because they are so many).
The most important API methods, however, should be implemented, so a person
with normal demands should have everything he needs.

If you feel like some API methods (that are not yet covered) should have
a higher priority to be covered, feel free to let me know (maybe best via
[Twitter](https://twitter.com/m_janko)), and I will try to get them covered
in the next version.  Pull requests are also very welcome :)

## Social

You can follow me on Twitter, I'm [@m_janko](https://twitter.com/m_janko).

## License

This project is released under the [MIT license](https://github.com/janko-m/flickr-objects/blob/master/LICENSE).
