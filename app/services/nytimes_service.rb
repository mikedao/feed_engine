class NytimesService

	def self.articles
		connection = Faraday.new(url: "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=b153eb5a98da885cf337dba80557ac1b:14:71760602")
		response = connection.get
		response_body = JSON.parse(response.body)
		articles = response_body["results"]
		articles.each do |article|
			Article.create(
				title: article["title"],
				url: article["url"],
				abstract: article["abstract"],
				desc_facet: clean_attribute(article["desc_facet"]),
				geo_facet: clean_attribute(article["geo_facet"])
			)
		end
	end

	private

	def self.clean_attribute(attribute)
		if attribute.class == String
			attribute
		else
			attribute ? attribute.join(",") : ""
		end
	end
end
