class NewsController < ApplicationController
  before_action :is_admin_user?, only: [:new, :create, :update, :destroy]

  def new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      @news.save
      redirect_to root_path
      flash[:info] = 'you success post news.'
    end
  end

  def show
    @news = News.find_by(id: params[:id])
  end

  def update
    @news = News.find_by(id: params[:id])
    if @news
      @news.update(news_params)
      redirect_to root_path
      flash[:info] = 'you success post update.'
    end
  end

  def index
    @news = News.all
  end

  def destroy
    @news = News.find_by(id: params[:id])
    if @news
      @news.destroy
      redirect_to root_path
      flash[:info] = 'you success post delete.'
    end
  end

  private
    def news_params
      params.require(:news).permit(:title, :contents)
    end
end
