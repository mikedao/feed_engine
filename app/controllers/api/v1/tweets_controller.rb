class Api::V1::TweetsController < ApplicationController
  include ActionController::Serialization
  def show
    render json: Tweet.find(params[:id])
  end
end
