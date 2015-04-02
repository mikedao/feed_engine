require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do

	describe "GET index" do
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
