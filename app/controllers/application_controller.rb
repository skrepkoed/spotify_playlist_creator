class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

	#before_action :require_login
	private

	def require_login
		#binding.pry 
		unless session[:user_id]

			
			redirect_to root_path

			
		end
		
	end
end
