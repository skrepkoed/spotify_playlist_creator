class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

	#before_action :require_login
	private

	def current_user
		if session[:user_id]
		@user=User.find session[:user_id]
		else
		end
		
	end
	def require_login
		#binding.pry 
		unless session[:user_id]

			
			redirect_to root_path

			
		end
		
	end
end
