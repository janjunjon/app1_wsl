class UsersController < ApplicationController
  before_action :is_lagis?
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to user_path(@user)
      flash[:success] = "ようこそ#{@user.name}さん！"
    else
      redirect_to new_user_path
      flash[:danger] = '入力情報が有効ではありません。'
    end
  end

  def index
    # @users = User.all
    @users = User.all.paginate(page: params[:page], per_page: 30)
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
      flash[:success] = "更新しました。"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
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
end
