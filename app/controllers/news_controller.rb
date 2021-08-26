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
    else
      render 'news/new'
      flash[:danger] = "what you posted was invalid."
    end
  end

  def update
    @news = News.find_by(id: params[:id])
    if @news
      @news.update(news_params)
      redirect_to root_path
      flash[:info] = 'you success post update.'
    else
      render 'news/edit'
      flash[:danger] = "what you posted was invalid."
    end
  end

  def index
    @news = News.order(created_at: :desc).limit(7)
  end

  def past
    @news = News.all.order(created_at: :desc)
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
      params.permit(:title, :contents, :info)
    end
end
