class Article < ActiveRecord::Base
  validates :title, uniqueness: true

  geocoded_by :geo_facet
  after_create :geocode #, if: ->(obj){ obj.geo_facet.present? }

  def self.create_articles(articles_data)
    articles_data.each do |article|
      article = _build_object(article)
      Article.create(
        title: article.title,
        url: article.url,
        abstract: article.abstract,
        desc_facet: _clean_attribute(article.des_facet),
        geo_facet: _clean_attribute(article.geo_facet)
      )
    end
  end

  private

  def self._clean_attribute(attribute)
    if attribute.class == String
      attribute
    else
      attribute ? attribute.join(",") : ""
    end
  end

  def self._clean_location(attribute)
    attribute ? attribute[0] : ""
  end

  def self._build_object(article)
    Hashie::Mash.new(article)
  end
end
