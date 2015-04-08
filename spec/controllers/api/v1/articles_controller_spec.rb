require "rails_helper"

RSpec.describe Api::V1::ArticlesController, type: :controller do

  describe "GET index" do
    it "renders json" do
      article = Article.create(title: "New Title",
                               url: "http://google.com",
                               abstract: "This is an abstract",
                               desc_facet: "keyword1, keyword2",
                               geo_facet: "Denver")
      get :index, format: :json
      first_article = JSON.parse(response.body)["articles"].first

      expect(first_article["title"]).to eq(article.title)
      expect(first_article["url"]).to eq(article.url)
      expect(first_article["abstract"]).to eq(article.abstract)
      expect(first_article["desc_facet"]).to eq(article.desc_facet)
      expect(first_article["geo_facet"]).to eq(article.geo_facet)
    end
  end

  describe "GET show" do
    it "renders json" do
      article = Article.create(title: "New Title",
                               url: "http://google.com",
                               abstract: "This is an abstract",
                               desc_facet: "keyword1, keyword2",
                               geo_facet: "Denver")
      tweet1 = article.tweets.create(body: "Turing schooll wins again",
                                     username: "j3",
                                     tweet_id: 123)
      tweet2 = article.tweets.create(body: "Some tweet",
                                     username: "bmrsny",
                                     tweet_id: 111)
      tweet3 = article.tweets.create(body: "Some other tweet",
                                     username: "j3",
                                     tweet_id: 222)
      get :show, format: :json, id: article.id
      body = JSON.parse(response.body)["article"]

      expect(body["title"]).to eq(article.title)
      expect(body["url"]).to eq(article.url)
      expect(body["abstract"]).to eq(article.abstract)
      expect(body["desc_facet"]).to eq(article.desc_facet)
      expect(body["geo_facet"]).to eq(article.geo_facet)
      expect(body["tweets"]).to eq([tweet1.tweet_id, tweet2.tweet_id, tweet3.tweet_id])
      expect(body["links"]["tweets"]).to eq("/articles/#{article.id}/tweets")
    end
  end
end
