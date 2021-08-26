class CodesController < ApplicationController
  include CodesHelper
  def index
  end

  def post
    @code = Code.first
    # if code_authenticated?(@code.password_digest, params[:code][:password])
    if @code.authenticate(params[:code][:password])
      # cookies.permanent.signed[:lagis_id] = 1
      # cookies.permanent[:lagis_authentication] = params[:code][:password]
      session[:lagis_id] = 1
      session[:lagis_authentication] = params[:code][:password]
      redirect_to root_path
      flash.now[:success] = "Lagisの認証コードが確認できました。"
    else
      render 'codes/index'
    end
  end

  def delete
  end

  def destroy
    delete_authentication
    redirect_to root_url
  end
end
