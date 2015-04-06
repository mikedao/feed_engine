class Api::V1::ArticlesController < ApplicationController
  respond_to :json, :xml

  def index
    render json: Article.all
  end
end
