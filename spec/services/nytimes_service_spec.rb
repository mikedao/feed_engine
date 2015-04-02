require 'rails_helper'

RSpec.describe NytimesService do

	describe "articles" do
		it "saves articles in db" do
			VCR.use_cassette("articles") do
        NytimesService.new.articles
			end

			expect(Article.first.title).to(
				eq("California Imposes Water Restrictions, in First for State")
			)
			expect(Article.first.url).to(
				eq("http://www.nytimes.com/2015/04/02/us/california-imposes-first-" +
					 "ever-water-restrictions-to-deal-with-drought.html")
			)
			expect(Article.first.abstract).to(
				eq("The move by Gov. Jerry Brown comes as California’s drought has " +
					 "reached near-crisis proportions after a winter that brought " +
					 "record-low snowfalls.")
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
