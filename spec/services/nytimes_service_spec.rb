require "rails_helper"

RSpec.describe NytimesService do

	describe "articles" do
		it "saves articles in db" do
			VCR.use_cassette("articles") do
        NytimesService.new.articles
			end

			expect(Article.first.title).to(
				eq("A Nuclear Deal Built on Coffee, Compromise and No Sleep")
			)
			expect(Article.first.url).to(
				eq("http://www.nytimes.com/2015/04/04/world/middleeast/" +
           "an-iran-nuclear-deal-built-on-coffee-all-nighters-and-" +
           "compromise.html")
			)
			expect(Article.first.abstract).to(
				eq("In hashing out one of the hardest-to-negotiate arms" +
           " control agreements in history, Iran and the United" +
           " States took a simple approach: stay in the same hotel" +
           " room until they figure out how to get along.")
			)
			expect(Article.first.desc_facet).to(
				eq("Nuclear Weapons,United States International Relations")
			)
			expect(Article.first.geo_facet).to(
				eq("Iran,United States")
			)
		end
  end
end
