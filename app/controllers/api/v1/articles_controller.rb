class Api::V1::ArticlesController < ApplicationController
  respond_to :json, :xml

  def index
		connection = Faraday.new(url: "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=b153eb5a98da885cf337dba80557ac1b:14:71760602")  
		response = connection.get
		response.body
		render json: Article.all
  end
end
