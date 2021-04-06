class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :logged_in_user, only: :show

	def index
		@articles = Article.all.paginate(page: params[:page], per_page: 10)
	end

	def search
		if params[:degree] == "学士"
			degree = "bachelor"
		elsif params[:degree] == "修士"
			degree = "master"
		end
		search_articles(degree)
	end

	def show
		@article = Article.find_by(id: params[:id])
	end
end
