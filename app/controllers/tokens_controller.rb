
class TokensController < ApplicationController


	def new

		resp=Token.request_access_token

		redirect_to resp.headers['location']	
	end


	def create

		tokens=Token.verify_access_token(code=params[:code])
		spotify_user_id=Token.get_spotify_user_id(tokens['access_token'])
		user=User.find session[:user_id]

		user.create_token(access_token:tokens['access_token'],refresh_token:tokens['refresh_token'],spotify_user_id:spotify_user_id)

		redirect_to user_path session[:user_id]	
	end

	
	
end
