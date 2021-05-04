class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user && @user.activated?
      @user.password_reset
      UserMailer.password_reset(@user, @user.password_reset_token).deliver_now
      message = "メールアドレスにパスワード再設定用のメールを送信しました、確認してください。"
      flash[:success] = message
      redirect_to root_path
    else
      flash.now[:danger] = "ユーザーが存在しないか、有効化されていません。"
      render 'password_resets/new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
    if !@user.authenticated?("password_reset", params[:id])
      flash[:danger] = "再設定用のページに遷移できません。"
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(email: params[:email])
    if params[:password] && params[:password_confirmation]
      @user.update(user_params)
      log_in @user
      flash[:success] = "パスワードを更新しました。"
      redirect_to @user
    else
      flash.now[:danger] = "パスワードを更新できませんでした。"
      render 'password_resets/edit'
    end
  end

  private
    def user_params
      params.permit(:password, :password_confirmation)
    end
end
