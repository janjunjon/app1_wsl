module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def is_logged_in?
        !current_user.nil?
    end

    def logout
        if session[:user_id]
            session.delete(:user_id)
        elsif cookies.signed[:user_id]
            cookies.delete(:user_id)
        end
        # session.delete(:lagis_id)
        # session.delete(:lagis_authentication)
    end

    def remember(user)
        user.remember
        cookies.permanent[:remember_token] = user.remember_token
        cookies.permanent.signed[:user_id] = user.id
    end

    def forget(user)
        if cookies.permanent[:remember_token] != nil
            user.forget
            cookies.delete(:user_id)
            cookies.delete(:remember_token)
            # cookies.permanent[:remember_digest].delete
            # cookies.permanent[:remember_digest] = nil
        end
    end

    def is_lagis?
        # if !cookies.permanent.signed[:id] && !cookies.permanent[:lagis_autentication]
        if !session[:lagis_id] && !session[:lagis_authentication]
            redirect_to lagis_path
            flash[:danger] = "Lagis認証コードが確認できていません。"
        end
    end

    def delete_authentication
        session.delete(:lagis_id)
        session.delete(:lagis_authentication)
    end

    def is_admin_user?
        if current_user.admin == false
            redirect_to root_path
            flash[:danger] = "you are not admin user."
        end
    end
end