require "tweetstream"

class TwitterFeed
  attr_reader :stream

  def initialize
    @stream = TweetStream::Client.new
  end

  TweetStream.configure do |config|
    config.consumer_key = ENV["twitter_consumer_key"]
    config.consumer_secret = ENV["twitter_consumer_secret"]
    config.oauth_token = ENV["twitter_oauth_token"]
    config.oauth_token_secret = ENV["twitter_oauth_secret"]
    config.auth_method = :oauth
  end

  def sample
    stream.sample do |tweet|
      Tweet.create(body: tweet.text)
    end
  end

  def track(term)
    stream.track(term)
  end
end
