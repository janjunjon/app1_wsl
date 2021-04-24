class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user && @user.activated?
      @user.password_reset
      @user.send_email("password_reset")
      message = "メールアドレスにパスワード再設定用のメールを送信しました、確認してください。"
      message += "http://192.168.33.10:3000/password_resets/#{@user.password_reset_token}/edit?email=#{@user.escape_email}"
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
