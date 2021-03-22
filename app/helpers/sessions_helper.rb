module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        @user = User.find_by(id: session[:user_id])
    end

    def is_logged_in?
        !current_user.nil?
    end

    def logout
        session.delete(:user_id)
    end

    def remember(user)
        token = user.mk_token
        digest = user.digest(token)
        cookies.permanent[:remember_digest] = digest
        cookies.permanent.signed[:user_id] = user.id
        user.remember_digest = digest
    end

    def forget(user)
        if cookies.permanent[:remember_digest] != nil
            # cookies.permanent[:remember_digest].delete
            cookies.permanent[:remember_digest] = nil
        end
    end
end
