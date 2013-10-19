module SessionsHelper

	def current_user
		@current_user ||= User.find_by_session_token(session[:session_token])
	end

	def current_user=(user)
		@current_user = user
	end

	def login_user!(user)
		user.reset_session_token!
		self.current_user = user
		session[:session_token] = user.session_token
	end

	def logout_user!
		self.current_user.reset_session_token!
		session[:session_token] = nil
	end

	def logged_in?
		self.current_user.nil? ? false : true
	end

end
