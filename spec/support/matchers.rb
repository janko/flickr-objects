RSpec::Matchers.define :be_a_nonempty do |klass|
  match do |actual|
    actual.is_a?(klass) and not actual.empty?
  end
end

RSpec::Matchers.define :be_an_empty do |klass|
  match do |actual|
    actual.is_a?(klass) and actual.empty?
  end
end

RSpec::Matchers.define :be_a_boolean do
  match do |actual|
    actual == true or actual == false
  end
end

RSpec::Matchers.define :be_an_existing_url do
  match do |url|
    connection = Faraday.new(url) do |builder|
      builder.use FaradayMiddleware::FollowRedirects, limit: 5
      builder.adapter :net_http
    end
    response = VCR.use_cassette("URL") { connection.get }
    response.should be_a_success
  end
end
