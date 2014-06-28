# Changelog

## Version 0.5.0

- Add support for caching reponses.

## Version 0.4.1

- Flickr's API transferred to SSL, and the calls over http:// no longer work,
  so flickr-objects now makes calls always over SSL.

## Version 0.4.0

- Added `flickr.interestingness.getList`.
- Fixed `sizes: true` not applying to `flickr.photos.getContactsPublicPhotos` and
  `flickr.photos.recentlyUpdated`.

## Version 0.3.0

- The code has been thoroughly refactored, and fully
  [documented](http://rubydoc.info/github/janko-m/flickr-objects/master/frames). Yay!
- Removed `Flickr.api_methods` – the consequences of its existence made the
  code uglier.
- Added `#find_by` and `#filter` to
  [`Flickr::Object::List`](http://rubydoc.info/github/janko-m/flickr-objects/master/Flickr/Object/List).
- You can now access the raw JSON response of a Flickr object with
  `#attributes`.
- Increased the default timeouts, so now the HTTP requests shouldn't timeout on
  normal internet connections

## Version 0.2.0

- Covered 17 more methods:

```
flickr.people.getPhotosOf
flickr.people.getUploadStatus

flickr.photos.getFavorites
flickr.photos.getNotInSet
flickr.photos.getRecent
flickr.photos.RecentlyUpdated
flickr.photos.getUntagged
flickr.photos.getWithGeoData
flickr.photos.getWithoutGeoData
flickr.photos.setDates
flickr.photos.setMeta
flickr.photos.setPerms
flickr.photos.setSafetyLevel

flickr.photosets.editMeta
flickr.photosets.orderSets
flickr.photosets.reorderPhotos
flickr.photosets.setPrimaryPhoto
```

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
