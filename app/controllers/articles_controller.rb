class ArticlesController < ApplicationController
	def index
		@articles = Article.all.paginate(page: params[:page], per_page: 10)
	end

	def show
		@article = Article.find_by(id: params[:id])
	end
end
