require "rails_helper"

RSpec.describe Article, type: :model do
  it "creates articles" do
    VCR.use_cassette("articles_locations") do
      article_data = [{
        title: "title",
        url: "url",
        abstract: "abstract",
        des_facet: "desc_facet",
        geo_facet: "indiana"
      }]

      Article.create_articles(article_data)

      expect(Article.first.title).to eq("title")
      expect(Article.first.url).to eq("url")
      expect(Article.first.abstract).to eq("abstract")
      expect(Article.first.desc_facet).to eq("desc_facet")
      expect(Article.first.geo_facet).to eq("indiana")
    end
  end

  it { should have_many(:tweets) }

  it "should build associated tweets from article url" do
    Article.create(url: "http://turing.io")
    VCR.use_cassette("article#build_associated_tweets") do
      Article.build_associated_tweets
    end

    expect(Tweet.first.body).to eq("RT @StevePolyak: Jeff Casimir @j3 director" +
                                   " at @TuringSchool http://t.co/O0QxUqjmKv" +
                                   " when cultivating innovation, it's all" +
                                   " about the people #…")
    expect(Tweet.first.username).to eq("j3")
    expect(Tweet.first.user_profile_image).to eq("http://pbs.twimg.com/" +
                                                 "profile_images/37880000054359" +
                                                 "9975/c63a58ff323b22a9e9ad52f"+
                                                 "fbbfb7f0a_normal.jpeg")
    expect(Tweet.first.tweet_id).to eq(584427863450914816)
    expect(Tweet.first.longitude).to eq(nil)
    expect(Tweet.first.latitude).to eq(nil)
    expect(Tweet.first.article_id).to eq(Article.first.id)
  end
end
