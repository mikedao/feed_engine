class Api::V1::ArticlesController < ApplicationController
  include ActionController::Serialization

  def index
    render json: Article.order(created_at: :desc), each_serializer: ArticleSerializer
  end

  def show
    render json: Article.find(params[:id])
  end
end
