

class SpotifyApiCall
	
	def self.call(user:nil, cursor:nil) 
	
	access_token= user.token.access_token
	
	responce=Faraday.get('https://api.spotify.com/v1/me/following?') do |req|

			req.headers['Authorization']='Bearer '+ access_token
			req.headers['Content-Type']='application/json'
			req.headers['Accept']='application/json'
			req.params['type']='artist'
			req.params['limit']='50'
			
			if cursor
				req.params['after']=cursor
			end

		end
		
		responce=JSON.parse(responce.body)
		
		responce[:user]=user
		
		responce
	end

end