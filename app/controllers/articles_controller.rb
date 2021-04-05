class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :logged_in_user, only: :show

	def index
		@articles = Article.all.paginate(page: params[:page], per_page: 10)
	end

	def search
		# search_articles
		if params[:degree] && params[:keyword] && params[:year] 
            @articles = Article.where("title like ? OR abstract like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(degree: params[:degree], year: params[:year]).paginate(page: params[:page], per_page: 10)
        elsif params[:degree] && !params[:keyword].present? && params[:year]
            @articles = Article.where(degree: params[:degree], year: params[:year]).paginate(page: params[:page], per_page: 10)
        elsif params[:degree] && params[:keyword] && !params[:year].present?
            @articles = Article.where("title like ? OR abstract like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").where(degree: params[:degree]).paginate(page: params[:page], per_page: 10)
        end
	end

	def show
		@article = Article.find_by(id: params[:id])
	end
end
