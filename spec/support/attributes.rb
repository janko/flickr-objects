ATTRIBUTES = {}

ATTRIBUTES[:upload_ticket] = {
  id:        proc { be_a_nonempty(String) },
  status:    proc { be_a(Integer) },
  invalid?:  proc { be_a_boolean },
  complete?: proc { be_a_boolean },
  failed?:   proc { be_a_boolean },
  photo:     proc { be_a(Flickr::Photo) },
}

ATTRIBUTES[:photo] = {
  id:                   proc { be_a_nonempty(String) },
  secret:               proc { be_a_nonempty(String) },
  server:               proc { be_a_nonempty(String) },
  farm:                 proc { be_a(Fixnum) },
  url:                  proc { be_a_nonempty(String) },
  uploaded_at:          proc { be_a(Time) },
  favorite?:            proc { be_a_boolean },
  license:              proc { be_a(Fixnum) },
  safety_level:         proc { be_a(Fixnum) },
  safe?:                proc { be_a_boolean },
  moderate?:            proc { be_a_boolean },
  restricted?:          proc { be_a_boolean },
  title:                proc { be_a_nonempty(String) },
  description:          proc { be_a_nonempty(String) },
  posted_at:            proc { be_a(Time) },
  taken_at:             proc { be_a(Time) },
  taken_at_granularity: proc { be_a(Fixnum) },
  updated_at:           proc { be_a(Time) },
  views_count:          proc { be_a(Fixnum) },
  comments_count:       proc { be_a(Fixnum) },
  has_people?:          proc { be_a_boolean },
  path_alias:           proc { be_nil },
  rotation:             proc { be_a(Integer) },
}

ATTRIBUTES[:person] = {
  id:                   proc { be_a_nonempty(String) },
  nsid:                 proc { be_a_nonempty(String) },
  username:             proc { be_a_nonempty(String) },
  real_name:            proc { be_a_nonempty(String) },
  location:             proc { be_a_nonempty(String) },
  icon_server:          proc { be_a(Fixnum) },
  icon_farm:            proc { be_a(Fixnum) },
  has_pro_account?:     proc { be_a_boolean },
  path_alias:           proc { be_nil },
  location:             proc { be_a_nonempty(String) },
  time_zone:            proc { be_a_nonempty(Hash) },
  description:          proc { be_a_nonempty(String) },
  photos_url:           proc { be_a_nonempty(String) },
  profile_url:          proc { be_a_nonempty(String) },
  mobile_url:           proc { be_a_nonempty(String) },
  photos_count:         proc { be_a(Integer) },
  photo_views_count:    proc { be_a(Integer) },
  first_photo_taken:    proc { be_a(Time) },
  first_photo_uploaded: proc { be_a(Time) },
  favorited_at:         proc { be_a(Time) },
}

ATTRIBUTES[:visibility] = {
  public?:   proc { be_a_boolean },
  friends?:  proc { be_a_boolean },
  family?:   proc { be_a_boolean },
  contacts?: proc { be_a_boolean },
}

ATTRIBUTES[:location] = {
  latitude:  proc { be_a(Float) },
  longitude: proc { be_a(Float) },
  accuracy:  proc { be_a(Integer) },
  context:   proc { be_a(Integer) },
  place_id:  proc { be_a_nonempty(String) },
  woe_id:    proc { be_a_nonempty(String) },
}

ATTRIBUTES[:area] = {
  name:     proc { be_a_nonempty(String) },
  place_id: proc { be_a_nonempty(String) },
  woe_id:   proc { be_a_nonempty(String) },
}

ATTRIBUTES[:tag] = {
  id:           proc { be_a_nonempty(String) },
  raw:          proc { be_a_nonempty(String) },
  content:      proc { be_a_nonempty(String) },
  machine_tag?: proc { be_a_boolean },
}

ATTRIBUTES[:list] = {
  current_page:  proc { be_a(Integer) },
  total_pages:   proc { be_a(Integer) },
  per_page:      proc { be_a(Integer) },
  total_entries: proc { be_a(Integer) },
}

ATTRIBUTES[:note] = {
  id:          proc { be_a_nonempty(String) },
  coordinates: proc { be_a(Array) },
  width:       proc { be_a(Integer) },
  height:      proc { be_a(Integer) },
}

ATTRIBUTES[:permissions] = {
  can_comment?:  proc { be_a_boolean },
  can_add_meta?: proc { be_a_boolean },
  can_download?: proc { be_a_boolean },
  can_blog?:     proc { be_a_boolean },
  can_print?:    proc { be_a_boolean },
  can_share?:    proc { be_a_boolean },
}

ATTRIBUTES[:set] = {
  id:             proc { be_a_nonempty(String) },
  secret:         proc { be_a_nonempty(String) },
  server:         proc { be_a_nonempty(String) },
  farm:           proc { be_a(Integer) },
  url:            proc { be_a_nonempty(String) },
  title:          proc { be_a_nonempty(String) },
  description:    proc { be_a_nonempty(String) },
  owner:          proc { be_a(Flickr::Person) },
  photos_count:   proc { be_a(Integer) },
  views_count:    proc { be_a(Integer) },
  comments_count: proc { be_a(Integer) },
  created_at:     proc { be_a(Time) },
  updated_at:     proc { be_a(Time) },
  primary_photo:  proc { be_a(Flickr::Photo) },
}
