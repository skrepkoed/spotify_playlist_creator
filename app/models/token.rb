class Token < ApplicationRecord
	belongs_to :user
	after_find :check_access_token

	private

	def check_access_token
		time_now=Time.zone.now

		ago=time_now.ago(3600)

		 case self.updated_at<=>ago 
		 
		 when -1 then self.update_access_token

		 when 0 then self.update_access_token
		  	 
		 	
		 end
		 
		
	end

	def update_access_token

		resp=Faraday.post('https://accounts.spotify.com/api/token') do |req|

			

			req.params[:grant_type]='refresh_token'
			req.params[:refresh_token]=self.refresh_token
			req.params[:client_id]='b6cd001838f8450191a5d06a4cc86179'
			req.params[:client_secret]=Rails.application.credentials.spotify_secret
			
		end
		new_access_token=JSON.parse(resp.body)['access_token']
		self.update(access_token:new_access_token)
		
	end
end
