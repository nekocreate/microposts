module SessionsHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def admin_user
        @admin_user ||= User.find_by(admin: true)
    end
    
    def logged_in?
        !!current_user
    end
    
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end
