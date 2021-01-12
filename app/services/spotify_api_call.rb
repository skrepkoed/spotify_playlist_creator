class SpotifyApiCall

	attr_reader :paging_items, :endpoint, :access_token, :options
	
	def self.call_s(endpoint, options) 
		
		call_to_spotify=new(options).send(endpoint)
		
		proc1=Proc.new do |req|

			
				req.headers['Authorization']='Bearer '+ call_to_spotify.access_token
				req.headers['Content-Type']='application/json'
				
				call_to_spotify.paging_items.call(req)
				

		end
		
		responce=Faraday.send(options.verb,(call_to_spotify.endpoint),&proc1)
			
			responce=JSON.parse(responce.body) 
			
			responce[:endpoint]=endpoint #!!!!!
			
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

	def create_playlist
		spotify_user_id=@options.spotify_user_id
		
		@endpoint="https://api.spotify.com/v1/users/#{spotify_user_id}/playlists"

		@paging_items=Proc.new do |req|

			req.body={'name'=> @options.name}.to_json 
			
		end
		self
	end

	def add_items_to_playlist

		playlist_id=@options.playlist_id

		@endpoint="https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"

		@paging_items=Proc.new do |req|

			req.body=@options.songs
			
		end
		self
	end

end