class TwitterService
  TWITTER_RADIUS = '1mi'
  def prepare_access_token
    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET,
                                   { :site => "http://api.twitter.com",
                                     :scheme => :header
    })
    token_hash = { :oauth_token => OAUTH_TOKEN,
                   :oauth_token_secret => OAUTH_SECRET }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
    return access_token
  end

  def get_tweets_for(school, topic)
    token = prepare_access_token
    geocode_value = [school.latitude, school.longitude, TWITTER_RADIUS].join(',')
    endpoint = "http://api.twitter.com/1.1/search/tweets.json?q=#{URI.encode(topic)}&geocode=#{geocode_value}&result_type=recent"
    response = token.request(:get, endpoint)
    body = JSON.parse(response.body)
    statuses = body['statuses']
    statuses.collect do |status|
      next unless Time.parse(status['created_at']) > 1.day.ago
      Tweet.new(screen_name: status['user']['screen_name'], text: status['text'], created_at: Time.parse(status['created_at']).strftime('%B %d, %Y %l:%M%p'))
    end.compact
  end
end
