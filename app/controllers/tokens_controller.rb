
class TokensController < ApplicationController


	def new

		resp=Faraday.get('https://accounts.spotify.com/authorize') do |req|

			req.params[:client_id]='b6cd001838f8450191a5d06a4cc86179'
			req.params[:response_type]='code'
			req.params[:redirect_uri]='http://localhost:3000/tokens/create'
			
		end

	redirect_to resp.headers['location']	
	end


	def create

		access_token= params[:code]

		resp=Faraday.post('https://accounts.spotify.com/api/token') do |req|

			req.params[:grant_type]='authorization_code'
			req.params[:code]=access_token
			req.params[:redirect_uri]='http://localhost:3000/tokens/create'
			req.params[:client_id]='b6cd001838f8450191a5d06a4cc86179'
			req.params[:client_secret]=Rails.application.credentials.spotify_secret
		end

		tokens=JSON.parse(resp.body)

		user=User.find session[:user_id]

		user.create_token(access_token:tokens['access_token'],refresh_token:tokens['refresh_token'], expires_at:tokens['expires_in'])

		redirect_to user_path session[:user_id]




		
	end

	
	
end
