class Api::V1::TweetsController < ApplicationController
  include ActionController::Serialization

  def index
    if params[:tweet_id]
      render json: Tweet.where(tweet_id: params[:tweet_id])
    elsif params[:article_id]
      render json: Tweet.where(article_id: params[:article_id])
    else
      render json: Tweet.all
    end
  end
end
