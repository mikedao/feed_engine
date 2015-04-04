require 'rails_helper'

RSpec.describe Tweet, type: :model do
  context "#build_tweets" do
    it "builds tweets" do
      data = [{
        text: "cool tweet",
        user: {
          screen_name: "user1",
          profile_image_url: "http://www.twitter.com",
          geo?: true,
          geo: {
            coordinates: [37.1891, -101.2342]
          }
        }
      }].map do |tweet|
        Hashie::Mash.new(tweet)
      end

      Tweet.build_tweets(data)
      tweet = Tweet.first

      expect(tweet.body).to eq("cool tweet")
      expect(tweet.username).to eq("user1")
      expect(tweet.user_profile_image).to eq("http://www.twitter.com")
    end
  end
end
