class Api::V1::TweetsController < ApplicationController
  def show
    render json: Tweet.find(params[:id])
  end
end
