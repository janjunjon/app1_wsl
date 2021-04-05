module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def logged_in_user
        if session[:user_id] == nil
          redirect_to login_path
          flash[:danger] = "ログインしてください"
        end
    end

    def current_user
        if session[:user_id]
            @current_user = User.find_by(id: session[:user_id])
        elsif cookies.signed[:user_id]
            @user = User.find_by(id: cookies.signed[:user_id])
            if @user && @user.authenticated?(cookies[:remember_token])
                @current_user = @user
            end
        end
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
end
