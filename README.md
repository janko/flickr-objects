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
person_id = "78733179@N04"
person = Flickr.people.find(preson_id)
photos = person.get_public_photos #=> API request

photo = photos.first
photo.id                 #=> "231233252"
photo.title              #=> "My cat"
photo.visibility.public? #=> true
photo.description        #=> nil
photo.get_info!          # makes an API request
photo.description        #=> "He's trying to catch a fly"
```

So, we've seen 2 API requests here:

- `person.get_public_photos` (`Flickr::Person#get_public_photos`)
- `photo.get_info!` (`Flickr::Photo#get_info!`)

They correspond to the API methods listed on Flickr's official [API page](http://flickr.com/api).
`Flickr::Person#get_public_photos` corresponds to `flickr.people.getPublicPhotos`, and
`Flickr::Photo#get_info!` corresponds to `flickr.photos.getInfo`.

Let's say you want to call Flickr's `flickr.photosets.getList`. To find out how to call it,
you can use `Flickr.api_methods` in the console. This method acts like a
documentation for API methods. So, for example:

```ruby
Flickr.api_methods["flickr.photosets.getList"] #=> ["Flickr::Person#get_sets"]
```

Now you found out that it corresponds to `Flickr::Person#get_sets`, which means
you can call it like this:

```ruby
sets = Flickr.people.find(person_id).get_sets
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

## Authenticated requests

If you need to make authenticated API requests (which you'll often want), you can create a kind
of a instance, assigning to it user's access token. That instance then has the same interface as `Flickr`.

```ruby
flickr = Flickr.new("ACCESS_TOKEN_KEY", "ACCESS_TOKEN_SECRET")

flickr.test_login #=> {"id" => "78733179@N04", "username" => ...}
flickr.people.find(person_id).get_public_photos
# ...
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
ticket_id = Flickr.upload("/path/to/photo.jpg", title: "Dandelions", ansync: true)
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
and `Flickr::Video` have can be found in `lib/flickr/objects/media.rb`.

![Flickr::Media](http://farm9.staticflickr.com/8195/8133340670_38c60aaca7.jpg)

As you can see, it is very readable ;)

## Few words

Most of the API methods are not covered yet (because they are so many for one
person). All the most important API methods should be implemented, so a person
with normal demands should have everything he needs. If you feel like some API
methods should have higher priority to be covered, feel free to post it in
issues, and I will try to get it covered in the next version. Pull requests are
also very welcome :)

## Social

You can follow me on Twitter, I'm [@m_janko](https://twitter.com/m_janko).

## License

This project is released under the [MIT license](https://github.com/janko-m/flickr-objects/blob/master/LICENSE).
