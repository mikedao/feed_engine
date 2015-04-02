class BuildTweetsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    TweetStream::Client.new.track(*terms) do |tweet|
      Tweet.create(body: tweet.text,
                   username: tweet.user.screen_name)
    end
  end
end
