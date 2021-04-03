class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :logged_in_user, only: :show

	def index
		if params[:degree].nil? && params[:keyword].nil? && params[:year].nil?
			@articles = Article.all.paginate(page: params[:page], per_page: 10)
		else
			search_articles
		end		
	end

	def show
		@article = Article.find_by(id: params[:id])
	end
end
