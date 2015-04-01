require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = ENV["twitter_consumer_key"]
  config.consumer_secret    = ENV["twitter_consumer_secret"]
  config.oauth_token        = ENV["twitter_oauth_token"]
  config.oauth_token_secret = ENV["twitter_oauth_secret"]
  config.auth_method        = :oauth
end

def sample
  TweetStream::Client.new.sample do |status|
    puts "#{status.user.name} - #{status.text}"
  end
end

def track(term)
  TweetStream::Client.new.track(term) do |status|
    puts "#{status.user.name} - #{status.text}"
  end
end
