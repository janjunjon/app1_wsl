module UsersHelper
    def escape_email(user)
        CGI.escape(user.email)
    end
end
