require "flickr-objects"
require_relative "spec/support/settings"
require "bundler"

Bundler::GemHelper.install_tasks

namespace :flickr do
  desc "Open the console with credentials (API key, secret etc.) already set up"
  task :console do
    require "pry"
    Pry.start
  end

  desc "Obtain your access token and NSID"
  task :authorize do
    request_token = Flickr::OAuth.get_request_token

    print <<-EOS.chomp
Visit this URL: #{request_token.authorize_url(perms: "delete")}
After you authorize, paste here the big number in the black box: 
    EOS

    oauth_verifier = STDIN.gets.strip
    access_token = request_token.get_access_token(oauth_verifier)

    puts <<-EOS

access_token_key:    #{access_token.key}
access_token_secret: #{access_token.secret}

fullname: #{access_token.user_info[:fullname]}
nsid:     #{access_token.user_info[:user_nsid]}
username: #{access_token.user_info[:username]}
    EOS
  end
end
