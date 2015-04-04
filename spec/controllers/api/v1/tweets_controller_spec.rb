require "rails_helper"

RSpec.describe Api::V1::TweetsController, type: :controller do
  describe "index" do
    xit "can respond with tweets" do
      get :index, format: :json

      expect(response.status).to eq(200)
      expect(Tweet.first.body).to eq("")
    end
  end
end
