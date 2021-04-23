class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?("activation", params[:id])
            user.activate_user
            log_in user
            message = "アカウントの有効化が完了しました。"
            message += "ログインしました。"
            flash[:success] = message
            redirect_to user
        else
            flash[:danger] = "アカウントの有効化が出来ませんでした。"
            redirect_to root_path
        end
    end
end
