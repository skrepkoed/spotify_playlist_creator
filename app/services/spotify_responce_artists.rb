class SpotifyResponceArtists<SpotifyResponce
	attr_accessor :artists_id

def initialize(options)
	@common_options=options
	@options=options.artist_option
	@type=@options.endpoint
	#####where if begins
	
	unless @common_options.spotify_ids.empty?



		@artists_id=@common_options.spotify_ids

	else

		super(@type, @options)
		@total=@raw_responce['artists'] ['total']
		
		@responce=@raw_responce['artists']['items'].map! { |e| SpotifyItem.new(e)  }
		@options.cursor=@raw_responce ['artists']['cursors']['after']
		self.next_page
		
	end

	
end

def add_next_page(responce)
	@responce+=responce['artists']['items'].map! { |e| SpotifyItem.new(e)  }
	@options.cursor =responce ['artists']['cursors']['after']
end


def options
	
	@common_options.item_option.endpoint= :albums
	@common_options.item_option.items_id=@artists_id
	@common_options.spotify_ids=[]
	unless  @artists_id
		#binding.pry
	self.random_items
	@common_options.item_option.items_id=@responce
	end
	@common_options	
end


end