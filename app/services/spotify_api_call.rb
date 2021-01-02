class SpotifyApiCall

	attr_reader :paging_items, :endpoint, :access_token, :options
	
	def self.call_s(endpoint, options) 
		
		call_to_spotify=new(options).send(endpoint)
		
		responce=Faraday.get(call_to_spotify.endpoint) do |req|

			
				req.headers['Authorization']='Bearer '+ call_to_spotify.access_token
				req.headers['Content-Type']='application/json'
				req.headers['Accept']='application/json'
				call_to_spotify.paging_items.call(req)
				

		end

			
			responce=JSON.parse(responce.body) 
			
			responce[:endpoint]=endpoint #!!!!!
			
			responce[:options]=options

			responce
			#binding.pry
	end

	def initialize(options)

		@access_token=options.token 
		@options=options
		@endpoint=nil
		
	end

	def artists

		@endpoint='https://api.spotify.com/v1/me/following?'

		@paging_items=Proc.new do |req|

			req.params['type']='artist'
				req.params['limit']='50'
				
				if @options.cursor
					req.params['after']=@options.cursor
				end
			
		end

		self
		
	end

	def get_items
		if @options.current_item==nil
			item_id=@options.items_id.delete_at 0 
			@options.current_item=item_id
				else
					item_id=@options.current_item
		end
		
		@paging_items=Proc.new do |req|

			req.params['limit']=@options.limit.to_s 

			if @options.offset!=0
					req.params['offset']=@options.offset
				end

			
		end
		item_id
	end

	def albums
		item_id= get_items
		@endpoint="https://api.spotify.com/v1/artists/#{item_id}/albums"
		self
	end

	def songs
		item_id= get_items
		@endpoint="https://api.spotify.com/v1/albums/#{item_id}/tracks"
		self
		
	end

end