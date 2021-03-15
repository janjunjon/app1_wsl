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
      redirect_to root_path
    else
      redirect_to login_path
    end
    # render 'new'
  end

  def destroy
  end
end
