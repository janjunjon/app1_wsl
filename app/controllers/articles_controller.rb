class ArticlesController < ApplicationController
	before_action :logged_in_user, only: :show

	def index
		if params[:degree] == nil || params[:keyword] == nil
			@articles = Article.all.paginate(page: params[:page], per_page: 10)
		else
			@articles = Article.where('abstract like ?', "%#{params[:keyword]}%").paginate(page: params[:page], per_page: 10)
			# @articles = Article.where(degree: params[:degree], abstract: "%#{params[:keyword]}%", year: params[:year]).paginate(page: params[:page], per_page: 10)
		end		
	end

	def show
		@article = Article.find_by(id: params[:id])
	end

	private
		def article_params
			params.require(:articles).permit(:degree, :submit)
		end
end
