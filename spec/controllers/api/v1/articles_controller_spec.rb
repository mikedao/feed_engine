require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do

  describe "GET index" do
    it "renders articles as json" do
      VCR.use_cassette("articles") do
        get :index, format: :json
      end

      expect(response).to have_http_status(:success)
      expect(response).to eq({})
    end
  end
end
