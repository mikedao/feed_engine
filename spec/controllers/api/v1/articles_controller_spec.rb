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

      expect(article["title"]).to eq(Article.first.title)
      expect(article["url"]).to eq(Article.first.url)
      expect(article["abstract"]).to eq(Article.first.abstract)
      expect(article["desc_facet"]).to eq(Article.first.desc_facet)
      expect(article["geo_facet"]).to eq(Article.first.geo_facet)
    end
  end
end
