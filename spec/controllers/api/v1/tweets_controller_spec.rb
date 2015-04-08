require "rails_helper"

RSpec.describe Api::V1::TweetsController, type: :controller do
  describe "index" do
    it "returns all tweets without params" do
      tweet1 = Tweet.create(body: "Turing schooll wins again",
                            username: "j3",
                            tweet_id: 123)
      tweet2 = Tweet.create(body: "Some tweet",
                            username: "bmrsny",
                            tweet_id: 111)
      tweet3 = Tweet.create(body: "Some other tweet",
                            username: "j3",
                            tweet_id: 222)

      get :index

      parsed_tweets = JSON.parse(response.body)["tweets"]

      expect(response.status).to eq(200)
      expect(parsed_tweets.first["body"]).to eq(tweet1.body)
      expect(parsed_tweets.first["username"]).to eq(tweet1.username)
      expect(parsed_tweets.last["body"]).to eq(tweet3.body)
      expect(parsed_tweets.last["username"]).to eq(tweet3.username)
    end

    it "returns tweets with article id as params" do
      article = Article.create(title: "article")
      article.tweets.create(body: "Turing schooll wins again",
                            username: "j3",
                            tweet_id: 123)
      article.tweets.create(body: "Some tweet",
                            username: "bmrsny",
                            tweet_id: 111)
      article.tweets.create(body: "Some other tweet",
                            username: "j3",
                            tweet_id: 222)
      unassociated_tweet = Tweet.create(body: "not associated",
                                        username: "j3",
                                        tweet_id: 333)

      get :index, article_id: article.id
      body = JSON.parse(response.body)["tweets"]

      expect(body.first["body"]).to eq(Tweet.first.body)
      expect(body.first["username"]).to eq(Tweet.first.username)
      expect(body.count).to eq(3)
      expect(body.any? do |tweet|
               tweet["id"] == unassociated_tweet.id
             end).to eq(false)
    end
  end
end
