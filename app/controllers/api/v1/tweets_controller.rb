class Api::V1::TweetsController < ApplicationController
  include ActionController::Serialization

  def index
    if params[:article_id]
      render json: Tweet.where(article_id: params[:article_id])
    else
      render json: Tweet.all
    end
  end
end
