class Api::V1::ArticlesController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Article.all
  end
end
