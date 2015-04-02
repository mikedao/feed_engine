require "twitter"

class TwitterRestApi
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["twitter_consumer_key"]
      config.consumer_secret = ENV["twitter_consumer_secret"]
      config.access_token = ENV["twitter_oauth_token"]
      config.access_token_secret = ENV["twitter_oauth_secret"]
    end
  end

  def search(*args)
    client.search(args, lang: "en")
  end
end
