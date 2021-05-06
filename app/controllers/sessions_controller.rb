class SessionsController < ApplicationController
  before_action :is_lagis?
  before_action :already_logged_in, only: [:new, :create]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        if params[:session][:remember] == '1'
          remember @user
        else
          forget @user
        end
        flash[:success] = "ログインしました。"
        if session[:current_url]
          redirect_to session[:current_url]
          session[:current_url] = nil
        else
          redirect_to root_path
        end
      else
        flash[:danger] = "アカウントが有効化されていません。"
        redirect_to root_path
      end
    else
      flash.now[:danger] = "メールアドレス・パスワードが適切ではありません。"
      render 'sessions/new'
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました。"
    redirect_to root_path
  end

  private
    def already_logged_in
      if current_user        
        redirect_to root_path
      end
    end
end
