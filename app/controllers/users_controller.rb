class UsersController < ApplicationController
  require 'aws-sdk-core'
  before_action :is_lagis?
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :already_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.save
      UserMailer.account_activation(@user, @user.activation_token).deliver_now
      redirect_to root_path
      message = "ユーザー認証のために、登録したメールアドレスを確認してください。"
      flash[:success] = message
    else
      render 'users/new'
      flash[:danger] = '入力情報が有効ではありません。'
    end
  end

  def index
    # @users = User.all
    @users = User.all.order(id: "DESC").paginate(page: params[:page], per_page: 30)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      Aws.use_bundled_cert!
      @user.image.attach(params[:user][:image])
      flash[:success] = "更新しました。"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    logout
    flash[:info] = "ユーザーを削除しました。"
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find_by(id: params[:id])
      if @user != current_user
        redirect_to users_path
        flash[:danger] = "適性ユーザーではありません。"
      end
    end

    def already_logged_in
      if current_user
        redirect_to root_path
      end
    end
end
