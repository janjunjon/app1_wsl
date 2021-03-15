class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.update(user_params)
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).require(:signup).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      @user = User.find_by(id: params[:id])
    end
end
