class SpotifyApiCall

	attr_reader :get_items, :endpoint, :access_token, :options
	
	def self.call_s(endpoint, options) 
		
		call_to_spotify=new(options).send(endpoint)
		
		responce=Faraday.get(call_to_spotify.endpoint) do |req|

			#binding.pry
				req.headers['Authorization']='Bearer '+ call_to_spotify.access_token
				req.headers['Content-Type']='application/json'
				req.headers['Accept']='application/json'
				call_to_spotify.get_items.call(req)
				

		end

			#binding.pry
			responce=JSON.parse(responce.body) 
			#binding.pry
			responce[:endpoint]=endpoint
			
			responce[:options]=options

			responce
	end

	def initialize(options)

		@access_token=options.token 
		@options=options
		@endpoint=nil
		
	end

	def artists

		@endpoint='https://api.spotify.com/v1/me/following?'

		@get_items=Proc.new do |req|

			req.params['type']='artist'
				req.params['limit']='50'
				
				if @options.cursor
					req.params['after']=@options.cursor
				end
			
		end

		self
		
	end

	def albums
		artist_id=@options.artists_id.delete_at 0 
		@endpoint="https://api.spotify.com/v1/artists/#{artist_id}/albums"
		@get_items=Proc.new do |req|

			req.params['limit']='50'

			if @options.offset!=0
					req.params['offset']=@options.offset
				end

			
		end
		self
	end

end