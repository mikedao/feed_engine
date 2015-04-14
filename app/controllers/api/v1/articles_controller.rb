class Api::V1::ArticlesController < ApplicationController
  include ActionController::Serialization

  def index
    render json: Article.all, each_serializer: ArticleIndexSerializer
  end

  def show
    render json: Article.find(params[:id])
  end
end
