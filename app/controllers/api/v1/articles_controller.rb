class Api::V1::ArticlesController < ApplicationController
  def index
    render json: Article.all, each_serializer: ArticleSerializer
  end

  def show
    render json: Article.find(params[:id])
  end
end
