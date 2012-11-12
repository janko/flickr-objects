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

Methods like `Flickr.photos.search` are "class" API methods, and methods like `photo.tags=` and
`photo.get_info!` are "instance" API methods.

- `Flickr.photos.search` <=> `Flickr::Photo.search`
- `photo.tags=`          <=> `Flickr::Photo#tags=`
- `photo.get_info!`      <=> `Flickr::Photo#get_info!`

API methods, of course, under the hood call raw API methods from Flickr's official [API page](http://flickr.com/api).
In our example, we have this correspondence:

- `Flickr::Photo.search`    <=> "flickr.photos.search"
- `Flickr::Photo#tags=`     <=> "flickr.photos.setTags"
- `Flickr::Photo#get_info!` <=> "flickr.photos.getInfo"

Raw Flickr's API methods always take a hash of parameters. So, for example,
"flickr.people.findByEmail" takes the `:find_email` parameter. But this gem
implies these parameters, so instead of having to call it like this:

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

# You can also call it like this:
photo.small240!
photo.width      #=> 240
```

So, in your (Rails) application, you could use it like this:

```erb
<% Flickr.people.find("78733179@N04").get_public_photos(sizes: :all).map(&:medium500!).each do |photo| %>
  <%= image_tag photo.source_url, size: "#{photo.width}x#{photo.height}" %>
<% end %>
```

## Authenticated requests

If you need to make authenticated API requests (which you'll probably often want), you can create a kind
of a instance, assigning to it the user's access token. That instance then has the same interface as `Flickr`.

```ruby
flickr = Flickr.new("ACCESS_TOKEN_KEY", "ACCESS_TOKEN_SECRET")

flickr.test_login #=> {"id" => "78733179@N04", "username" => ...}
flickr.people.find("78733179@N04").get_photos #=> [#<Flickr::Photo ...>, #<Flickr::Photo, ...>, ...]
```

If you're in a Rails application, probably the best solution for authenticating
users through Flickr (thus obtaining their access tokens) is the
[omniauth-flickr](https://github.com/timbreitkreutz/omniauth-flickr) gem.
Another (more lightweight) solution would be [flickr-login](https://github.com/janko-m/flickr-login).

You can also assign the access token globally in your configuration.

```ruby
Flickr.configure do |config|
  config.api_key = "API_KEY"
  config.shared_secret = "SHARED_SECRET"
  config.access_token_key = "ACCESS_TOKEN_KEY"
  config.access_token_secret = "ACCESS_TOKEN_SECRET"
end
```

This is useful if you're, for example, using Flickr as a photo storage in your
application, and that access token is actually yours.


## Upload

```ruby
photo_id = Flickr.upload("/path/to/photo.jpg", title: "Dandelions")
photo = Flickr.photos.find(photo_id).get_info!
photo.title #=> "Dandelions"
```

You can also upload asynchronously, which will return the upload ticket, which
you can then use to check when the upload has finished.

```ruby
ticket_id = Flickr.upload("/path/to/photo.jpg", title: "Dandelions", async: 1)
ticket = Flickr.check_upload_tickets(ticket_id).first
ticket.complete? #=> false

sleep 1

ticket = Flickr.check_upload_tickets(ticked_id).first
ticket.complete? #=> true
ticket.photo.id #=> "232594385"
```

## Attributes

For the list of attributes that Flickr objects have, the best place to look at
is the source code. For example, list of common attributes that `Flickr::Photo`
and `Flickr::Video` have can be found in [`lib/flickr/objects/media.rb`]("https://github.com/janko-m/flickr-objects/blob/master/lib/flickr/objects/media.rb").

![Flickr::Media](http://farm9.staticflickr.com/8195/8133340670_38c60aaca7.jpg)

As you can see, it is very readable ;)

## Few words

Most of the API methods are not covered yet (because they are so many).
The most important API methods should be already implemented, so a person
with normal demands should have everything he needs. If you feel like some API
methods (that are not yet covered) should have a higher priority to be covered,
feel free to let me know (maybe best via Twitter, see below), and I will try to
get them covered in the next version. Pull requests are also very welcome :)

## Social

You can follow me on Twitter, I'm [@m_janko](https://twitter.com/m_janko).

## License

This project is released under the [MIT license](https://github.com/janko-m/flickr-objects/blob/master/LICENSE).
