class CodesController < ApplicationController
  def index
  end

  def post
    @code = Code.find(1)
    if @code.authenticate(params[:code][:password])
      cookies.permanent.signed[:id] = 1
      cookies.permanent[:lagis_autentication] = params[:code][:password]
      # session[:id] = 1
      # session[:lagis_autentication] = params[:code][:password]
      redirect_to root_path
      flash[:success] = "Lagisの認証コードが確認できました。"
    else
      render 'codes/index'
    end
  end
end
