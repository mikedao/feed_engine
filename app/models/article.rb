class Article < ActiveRecord::Base
  validates :title, uniqueness: true

  def self.create_articles(articles_data)
    articles_data.map do |article|
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

  def keyword_base_text
    base_text_data = [title,
                      desc_facet.gsub(/,/, " "),
                      abstract]
    base_text_data.map do |attribute|
      attribute.gsub(/[^\w]+/, " ").split(" ")
    end.flatten.join(" ")
  end

  private

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
end
