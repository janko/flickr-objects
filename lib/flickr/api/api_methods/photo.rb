class Flickr
  class Photo < Object
    class_api_method :get_from_contacts,    "flickr.photos.getContactsPhotos"
    class_api_method :search,               "flickr.photos.search"
    class_api_method :delete,               "flickr.photos.delete"
    class_api_method :get_not_in_set,       "flickr.photos.getNotInSet"
    class_api_method :get_recent,           "flickr.photos.getRecent"
    class_api_method :get_untagged,         "flickr.photos.getUntagged"
    class_api_method :get_with_geo_data,    "flickr.photos.getWithGeoData"
    class_api_method :get_without_geo_data, "flickr.photos.getWithoutGeoData"
    class_api_method :get_recently_updated, "flickr.photos.RecentlyUpdated"

    instance_api_method :add_tags,         "flickr.photos.addTags"
    instance_api_method :delete,           "flickr.photos.delete"
    instance_api_method :get_info!,        "flickr.photos.getInfo"
    instance_api_method :get_sizes!,       "flickr.photos.getSizes"
    instance_api_method :get_exif,         "flickr.photos.getExif"
    instance_api_method :get_favorites,    "flickr.photos.getFavorites"
    instance_api_method :remove_tag,       "flickr.photos.removeTag"
    instance_api_method :set_content_type, "flickr.photos.setContentType", aliases: [:content_type=]
    instance_api_method :set_tags,         "flickr.photos.setTags",        aliases: [:tags=]
    instance_api_method :set_dates,        "flickr.photos.setDates"
    instance_api_method :set_meta,         "flickr.photos.setMeta"
    instance_api_method :set_permissions,  "flickr.photos.setPerms"
    instance_api_method :set_safety_level, "flickr.photos.setSafetyLevel"
  end
end
