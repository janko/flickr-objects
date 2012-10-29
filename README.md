# Flickr Objects

This gem is an object-oriented wrapper for the [Flickr API](http://flickr.com/api).
To see its capability, take a look at this quick demonstration:

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

So, now you know that you can call it like this:

```ruby
Flickr.people(person_id).get_sets
```
