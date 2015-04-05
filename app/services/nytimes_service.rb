class NytimesService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=#{ENV['nytimes']}")
  end

  def articles
    response_body = parse(connection.get)
    binding.pry
    articles_data = response_body["results"]
    Article.create_articles(articles_data)
  end

  private

  def parse(data)
    JSON.parse(data.body)
  end
end
