class Tweet < ActiveRecord::Base
  def self.build_tweets(data)
    data.each do |tweet|
      Tweet.create(body: tweet.text,
                   username: tweet.user.screen_name,
                   user_profile_image: tweet.user.profile_image_url,
                   latitude: add_coordinates("lat", tweet),
                   longitude: add_coordinates("long", tweet))
    end
  end

  private

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
end
