class TweetJob
  include SuckerPunch::Job

  def perform(event)
    TweetStream::Client.new.sample do |tweet|
      Tweet.create(body: tweet.text,
                   username: tweet.user.screen_name)
    end
  end
end
