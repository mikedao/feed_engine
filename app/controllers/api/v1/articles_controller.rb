class Api::V1::ArticlesController < ApplicationController
	respond_to :json, :xml

	def index
		NytimesService.new.articles		
		render json: Article.all
	end
end
