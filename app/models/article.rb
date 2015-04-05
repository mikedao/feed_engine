class Article < ActiveRecord::Base
  validates :title, uniqueness: true

  def self.create_articles(articles_data)
    articles_data.map do |article|
      article = _build_object(article)
      current_article = Article.new(
        title: article.title,
        url: article.url,
        abstract: article.abstract,
        desc_facet: _clean_attribute(article.des_facet),
        geo_facet: _clean_location(article.geo_facet),
      )
      if current_article.save
        current_article.update(
          latitude: _get_latlon(current_article.id)["lat"],
          longitude: _get_latlon(current_article.id)["lng"]
        )
      end
    end
  end

  def keyword_base_text
    base_text_data = [title, desc_facet, abstract]
    base_text_data.map do |attribute|
      attribute.gsub(/[^\w]+/, " ").split(" ")
    end.flatten.join(" ")
  end

  def self.add_keywords_to_articles
    keyword_engine = KeywordEngine.new
    all.each do |article|
      keywords = keyword_engine.generate_keywords(article)
      article.update(keywords: keywords)
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
    if attribute.class == String
      attribute
    else
      attribute ? attribute[0] : ""
    end
  end

  def self._build_object(article)
    Hashie::Mash.new(article)
  end

  def self._get_latlon(id)
    article = Article.find(id)
    if article.geo_facet.present?
      locdata ||= Hashie::Mash.new(GeocodeService.new.geocode_info(article.geo_facet))
      locdata.results.first.geometry.location
    else
      { "lat" => "", "lng" => "" }
    end
  end
end
