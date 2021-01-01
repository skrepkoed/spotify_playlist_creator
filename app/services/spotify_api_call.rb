class SpotifyApiCall

	attr_reader :get_artists, :endpoint, :access_token
	
	def self.call_s(endpoint, options) 
		
		call_to_spotify=new(options).send(endpoint)
		
		responce=Faraday.get(call_to_spotify.endpoint) do |req|

			#binding.pry
				req.headers['Authorization']='Bearer '+ call_to_spotify.access_token
				req.headers['Content-Type']='application/json'
				req.headers['Accept']='application/json'
				call_to_spotify.get_artists.call(req)
				

		end

			#binding.pry
			responce=JSON.parse(responce.body)
			
			responce[:endpoint]=:artists
			
			responce[:options]=options

			responce
	end

	def initialize(options)

		@access_token=options[:access_token]
		@cursor=options[:cursor]
		@offset=options[:offset]
		@artists_id=[:artists_id]
		@endpoint=nil
		
	end

	def artists

		@endpoint='https://api.spotify.com/v1/me/following?'

		@get_artists=Proc.new do |req|

			req.params['type']='artist'
				req.params['limit']='50'
				
				if @cursor
					req.params['after']=@cursor
				end
			
		end

		self
		
	end

	def albums
		
	end

end