require "rails_helper"

RSpec.describe Article, type: :model do
  it "creates articles" do
    VCR.use_cassette("articles_locations") do
      article_data = [{
        title: "title",
        url: "url",
        abstract: "abstract",
        des_facet: "desc_facet",
        geo_facet: "indiana",
        byline: "author",
        published_date: "2015-04-10",
        section: "section",
        subsection: "subsection"
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

    expect(Tweet.first.body).to eq("@CCandUC you and Logan graduated from http://t.co/kIeZ3vlLHW, right? What'd you think? How's does the mentoring work?")
    expect(Tweet.first.username).to eq("iamvery")
    expect(Tweet.first.user_profile_image).to eq("http://pbs.twimg.com/profile_images/582243875433144320/4rYLkXVH_normal.jpg")
    expect(Tweet.first.tweet_id).to eq(586336225549754368)
    expect(Tweet.first.longitude).to eq(nil)
    expect(Tweet.first.latitude).to eq(nil)
    expect(Tweet.first.article_id).to eq(Article.first.id)
  end

  it "can generate keywords" do
    VCR.use_cassette("nytimes_articles") do
      allow(Article).to receive(:_get_latlon).and_return("lat" => 1.5, "lng" => 1.5)
      NytimesService.new.articles
    end

    expect(Article.first.keywords).to eq("paul,machine,vowing,says,contender")
    expect(Article.last.keywords).to eq("restaurants,winter,greek,estiatorio,milos")
  end
end
