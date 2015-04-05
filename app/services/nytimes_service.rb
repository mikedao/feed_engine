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
    Article.add_keywords_to_articles
  end

  private

  def parse(data)
    JSON.parse(data.body)
  end
end
