# Contributing

## Running tests

Run the tests with:

```sh
$ bundle exec rspec
```

## Writing new tests

If you want to write new tests, you'll need to create an account on Flickr
and apply for the API key.

First, copy `spec/settings.yml.example` into `spec/settings.yml`.

The API key and shared secret you obtain by applying for them [here](http://www.flickr.com/services/apps/create/apply).
(You'll need to provide the reason to Flickr for why you need them, but you'll
be able to use them instantly.) Then put them in your `settings.yml`.

After that you'll just need to authorize your account:

```sh
$ bundle exec rake flickr:authorize
```

And then you enter the access token in your `spec/settings.yml`. And that's it,
you're done. Note that you can also use ERB.

You'll notice that in `spec/settings.yml` you have some additional parameters that
are set to null. You can override them if you wish to. For their explanation,
take a look at [`Flickr::Configuration`](http://rubydoc.info/github/janko-m/flickr-objects/master/Flickr/Configuration)
