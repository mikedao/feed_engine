require "rails_helper"

RSpec.describe Article, type: :model do
  it "creates articles" do
    article_data = [{
      title: "title",
      url: "url",
      abstract: "abstract",
      desc_facet: "desc_facet",
      geo_facet: "geo_facet"
    }]

    Article.create_articles(article_data)

    expect(Article.first.title).to eq("title")
    expect(Article.first.url).to eq("url")
    expect(Article.first.abstract).to eq("abstract")
    expect(Article.first.desc_facet).to eq("desc_facet")
    expect(Article.first.geo_facet).to eq("geo_facet")
  end

  it {should have_many(:tweets)}

 xit "should build associated tweets from article url" do
     article_data = [{
      title: "title",
      url: "http://example.com",
      abstract: "abstract",
      desc_facet: "desc_facet",
      geo_facet: "geo_facet"
    }]

   article =  Article.create_articles(article_data)
   #TODO stub and mock out this method -> Article.build_associated_tweets
  end
end
