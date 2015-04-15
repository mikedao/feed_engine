class Tweet < ActiveRecord::Base
  validates :tweet_id, :body, uniqueness: true
  belongs_to :article

  def self.build_tweets(data, article_id)
    data.each do |tweet|
      tweet_data = _build_object(tweet)
      Tweet.create(body: tweet_data.text,
                   username: tweet_data.user.screen_name,
                   user_profile_image: tweet_data.user.profile_image_url,
                   latitude: add_coordinates("lat", tweet_data),
                   longitude: add_coordinates("long", tweet_data),
                   tweet_id: tweet_data.id,
                   published_time: tweet_data.created_at.to_datetime,
                   article_id: article_id)
    end
  end

  def self.add_coordinates(dir, tweet)
    tweet.geo? ? set_coordinate(dir, tweet) : nil
  end

  def self.set_coordinate(dir, tweet)
    if dir == "lat"
      tweet.geo.coordinates.first.to_f
    elsif dir == "long"
      tweet.geo.coordinates.last.to_f
    end
  end

  def self._build_object(tweet)
    Hashie::Mash.new(tweet)
  end
end
