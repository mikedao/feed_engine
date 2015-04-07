require "rails_helper"

RSpec.describe Api::V1::TweetsController, type: :controller do
  describe "show" do
    it "returns json with one tweet" do
      tweet = Tweet.create(body: "Turing schooll wins again",
                            username: "j3")
      get :show, format: :json, id: tweet.id

      first_tweet = JSON.parse(response.body)["tweet"]

      expect(response.status).to eq(200)
      expect(first_tweet["body"]).to eq(tweet.body)
      expect(first_tweet["username"]).to eq(tweet.username)
    end

    it "returns json with multiple  tweet ids" do
      tweet1 = Tweet.create(body: "Turing schooll wins again",
                            username: "j3",
                            tweet_id: 123)
      tweet2 = Tweet.create(body: "Some tweet",
                            username: "bmrsny",
                            tweet_id: 111)
      tweet3 = Tweet.create(body: "Some other tweet",
                            username: "j3",
                            tweet_id: 222)
      tweets = [tweet1.id, tweet2.id, tweet3.id]


      get :show, format: :json, id: tweets

      parsed_tweets = JSON.parse(response.body)["tweets"]

      expect(response.status).to eq(200)
      expect(parsed_tweets.first["body"]).to eq(tweet1.body)
      expect(parsed_tweets.first["username"]).to eq(tweet1.username)
      expect(parsed_tweets.last["body"]).to eq(tweet3.body)
      expect(parsed_tweets.last["username"]).to eq(tweet3.username)
    end
  end
end
