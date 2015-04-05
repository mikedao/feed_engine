require "rails_helper"

RSpec.describe NytimesService do

	describe "articles" do
		it "saves articles in db" do
			VCR.use_cassette("articles") do
        NytimesService.new.articles
			end

			expect(Article.first.title).to(
				eq("California Drought Tests History of Endless Growth")
			)
			expect(Article.first.url).to(
				eq("http://www.nytimes.com/2015/04/05/us/california-drought-tests-history" +
           "-of-endless-growth.html")
			)
			expect(Article.first.abstract).to(
				eq("The state&#8217;s history as a frontier of prosperity and glamour faces " +
            "an uncertain future as the fourth year of severe shortages prompts" +
            " Gov. Jerry Brown to mandate a 25 percent reduction in" +
            " non-agricultural water use.")
			)
			expect(Article.first.desc_facet).to(
				eq("")
			)
			expect(Article.first.geo_facet).to(
				eq("California")
			)
		end
  end
end
