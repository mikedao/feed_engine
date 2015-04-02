require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do

	describe "GET index" do
		it "saves articles in db" do
			VCR.use_cassette("articles") do
				get :index, format: :json
			end

			expect(response).to have_http_status(:success)
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

		it "renders json" do
			VCR.use_cassette("articles") do
				get :index, format: :json
			end
			data = JSON.parse(response.body)	
			
			expect(data.first["title"]).to eq(Article.first.title)
			expect(data.first["url"]).to eq(Article.first.url)
			expect(data.first["abstract"]).to eq(Article.first.abstract)
			expect(data.first["desc_facet"]).to eq(Article.first.desc_facet)
			expect(data.first["geo_facet"]).to eq(Article.first.geo_facet)
		end
	end
end
