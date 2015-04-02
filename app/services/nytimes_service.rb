class NytimesService
	attr_reader :connection
	def initialize
		@connection ||= Faraday.new(url: "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=b153eb5a98da885cf337dba80557ac1b:14:71760602")
	end

	def articles
		response_body = parse(connection.get)
		articles = response_body["results"]
		create_articles(articles)
	end

	private

	def create_articles(articles_data)
		articles_data.each do |article|
			Article.create(
				title: article["title"],
				url: article["url"],
				abstract: article["abstract"],
				desc_facet: clean_attribute(article["desc_facet"]),
				geo_facet: clean_attribute(article["geo_facet"])
			)
		end
	end

	def parse(data)
		JSON.parse(data.body)
	end

	def clean_attribute(attribute)
		if attribute.class == String
			attribute
		else
			attribute ? attribute.join(",") : ""
		end
	end
end
