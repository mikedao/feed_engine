require "rails_helper"

RSpec.describe Api::V1::ArticlesController, type: :controller do

  describe "GET index" do
    xit "renders json" do
      article = Article.create(title: "New Title",
                               url: "http://google.com",
                               abstract: "This is an abstract",
                               desc_facet: "keyword1, keyword2",
                               geo_facet: "Denver")
      get :index, format: :json
      require "pry" 
       binding.pry
      first_article = JSON.parse(response.body)["articles"].first

      expect(first_article["title"]).to eq(article.title)
      expect(first_article["url"]).to eq(article.url)
      expect(first_article["abstract"]).to eq(article.abstract)
      expect(first_article["desc_facet"]).to eq(article.desc_facet)
      expect(first_article["geo_facet"]).to eq(article.geo_facet)
    end
  end

  describe "GET show" do
    xit "renders json" do
      article = Article.create(title: "New Title",
                               url: "http://google.com",
                               abstract: "This is an abstract",
                               desc_facet: "keyword1, keyword2",
                               geo_facet: "Denver")
      get :show, format: :json, id: article.id 
      body = JSON.parse(response.body)["article"]

      expect(body["title"]).to eq(article.title)
      expect(body["url"]).to eq(article.url)
      expect(body["abstract"]).to eq(article.abstract)
      expect(body["desc_facet"]).to eq(article.desc_facet)
      expect(body["geo_facet"]).to eq(article.geo_facet)
    end
  end
end
