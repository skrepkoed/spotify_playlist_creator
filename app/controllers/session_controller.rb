class SessionController < ApplicationController


	def new
		
	end

	def create
		@user=User.find_by(login:params[:login])
		#binding.pry
		if @user && @user.authenticate(params[:password])

			session[:user_id]=@user.id



			redirect_to user_path @user.id

		else

			redirect_to root_path
			
		end
		
	end

	def destroy

		session[:user_id]=nil

		redirect_to root_path
		
	end
end
