class UsersController < ApplicationController

	before_action :require_login, except: [:new, :create], raise: false
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

		@session=session

		#@artists=@user.token.get_users_artists

		@artists=SpotifyResponce.new(SpotifyApiCall.call(user:@user) ).responce

		#binding.pry
		
	end

	

	private

	def params_user

		params.require(:user).permit(:login, :password)
		
	end
end
