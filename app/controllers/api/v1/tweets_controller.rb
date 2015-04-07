class Api::V1::TweetsController < ApplicationController
  include ActionController::Serialization

  def index
    if params[:tweet_id]
      render json: Tweet.where(tweet_id: params[:tweet_id])
    elsif
      render json: Tweet.all
    end
  end
end
