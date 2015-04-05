require "rails_helper"

RSpec.describe Tweet, type: :model do
  context "#build_tweets" do
    it "builds tweets" do
      article = Article.create(title: "My title",
                               abstract: "abstract here",
                               desc_facet: "I am a description",
                               geo_facet: "20.99, -89.888")
      data = [{
        text: "cool tweet",
        geo?: true,
        geo: {
          coordinates: [37.1891, -101.2342]
        },
        user: {
          screen_name: "user1",
          profile_image_url: "http://www.twitter.com",
        }
      }]

      Tweet.build_tweets(data, article.id)
      tweet = Tweet.first

      expect(tweet.body).to eq("cool tweet")
      expect(tweet.username).to eq("user1")
      expect(tweet.user_profile_image).to eq("http://www.twitter.com")
      expect(tweet.latitude).to eq(37.1891)
      expect(tweet.longitude).to eq(-101.2342)
      expect(tweet.article_id).to eq(article.id)
    end
  end
  it { should belong_to(:article) }
end
