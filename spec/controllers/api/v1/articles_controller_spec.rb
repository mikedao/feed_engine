require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do

	describe "GET index" do
		it "renders articles as json" do
			VCR.use_cassette("articles") do

				get :index, format: :json
				expect(Article.first.title).to eq("")
				expect(response).to have_http_status(:success)
			end
		end
	end
end
