require "flickr-objects"
require "yaml"
require "erb"
require "active_support/core_ext/hash/keys"

begin
  path = File.join(Bundler.root, "spec/settings.yml")
  yaml = ERB.new(File.read(path)).result
  settings = YAML.load(yaml).symbolize_keys
  SETTINGS = settings
rescue Errno::ENOENT
  SETTINGS = {}
end

Flickr.configure do |config|
  SETTINGS.each do |name, value|
    config.send(:"#{name}=", value) if config.respond_to?(:"#{name}=")
  end
end

EXTRAS = %w[description license date_upload date_taken owner_name icon_server
            original_format last_update geo tags machine_tags o_dims views
            media path_alias url_sq url_q url_t url_s url_n url_m url_z url_c
            url_l url_h url_k url_o].join(",")
