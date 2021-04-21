class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :is_lagis?
	before_action :logged_in_user, only: :show

	def index
		@articles = Article.all.paginate(page: params[:page], per_page: 10)
	end

	def search
		search_articles
	end

	def show
		@article = Article.find_by(id: params[:id])
	end
end
