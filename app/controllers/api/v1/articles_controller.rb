class Api::V1::ArticlesController < ApplicationController
	respond_to :json, :xml

	def index
		NytimesService.articles		
		render json: Article.all
	end
end
