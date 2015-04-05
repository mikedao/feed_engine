class Article < ActiveRecord::Base
  validates :title, uniqueness: true
  has_many :tweets

  def self.create_articles(articles_data)
    articles_data.each do |article|
      article = _build_object(article)
      Article.create(
        title: article.title,
        url: article.url,
        abstract: article.abstract,
        desc_facet: _clean_attribute(article.desc_facet),
        geo_facet: _clean_attribute(article.geo_facet)
      )
    end
  end

  def self._clean_attribute(attribute)
    if attribute.class == String
      attribute
    else
      attribute ? attribute.join(",") : ""
    end
  end

  def self._build_object(article)
    Hashie::Mash.new(article)
  end

  def self.build_associated_tweets
    all.each do |article|
      tweets = TwitterRestApi.new.search_by(article.url)
      data = tweets.attrs[:statuses]
      article_id = article.id
      Tweet.build_tweets(data, article_id)
    end
  end
end
