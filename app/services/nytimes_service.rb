class NytimesService
  attr_reader :connection

  def initialize
    @connection ||= Faraday.new(url: "http://api.nytimes.com/svc/topstories/" +
                                "v1/home.json?api-key=#{ENV['NYTIMES_KEY']}")
  end

  def articles
    response_body = parse(connection.get)
    articles_data = response_body["results"]
    Article.create_articles(articles_data)
    generate_article_keywords
  end

  private

  def parse(data)
    JSON.parse(data.body)
  end

  def generate_article_keywords
    keyword_engine = KeywordEngine.new
    Article.all.each do |article|
      keywords = keyword_engine.generate_keywords(article)
      article.update(keywords: keywords)
    end
  end
end
