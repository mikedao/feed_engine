require "twitter"

class TwitterRestApi
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV.fetch("twitter_consumer_key")
      config.consumer_secret = ENV.fetch("twitter_consumer_secret")
    end
  end

  def search_by(terms)
    client.search(terms)
  end
end
