class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      if params[:session][:remember] == 1
        remember(@user)
      else
        forget(@user)
      end
      flash[:success] = "ログインしました。"
      redirect_to root_path
    else
      flash[:danger] = "ログインできませんでした。"
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました。"
    redirect_to root_path
  end
end
