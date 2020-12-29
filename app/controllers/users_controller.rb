class UsersController < ApplicationController

	skip_before_action :require_login, execept: [:new, :create]
	def new

		@user=User.new
		
	end

	def create

		@user=User.create(params_user)

		session[:user_id]=@user.id

#		redirect_to user_path @user.id

		redirect_to tokens_new_path
		
	end

	def show

		@user=User.find(params[:id])

		@artists=@user.token.get_users_artists['artists']['items']

		#binding.pry
		
	end

	

	private

	def params_user

		params.require(:user).permit(:login, :password)
		
	end
end
