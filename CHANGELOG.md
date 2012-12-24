# Changelog

## Version 0.1.0

- On objects that have an ID, `#==` will now compare their IDs (useful when you
  get the same object from different sources)
- Implemented dynamic finders (`#find_by_<attribute>`) on `Flickr::List`.
- Implemented authentication. Take a look at [this
  wiki](https://github.com/janko-m/flickr-objects/wiki/Authentication).
- Removed videos completely. Too much hacking, because Flickr's API doesn't have
  a good support for them.
- Implemented smart size methods. Take a look at [this wiki](https://github.com/janko-m/flickr-objects/wiki/Sizes)
- Implemented pagination. Supports both Will Paginate and Kaminari. Take a look
  at [this wiki](https://github.com/janko-m/flickr-objects/wiki/Configuration),
  under "Pagination" for how to enable it.
