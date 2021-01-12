class SpotifyResponceItems<SpotifyResponce

attr_accessor :albums_id

def initialize(options)
	
	@common_options=options
	@options=options.item_option
	@type=@options.endpoint
	unless @common_options.spotify_ids.empty?
		
		@albums_id=@common_options.spotify_ids

	else

		super(@type, @options)
		
		@responce=@raw_responce['items'].map{|i| SpotifyItem.new(i)}
		@total=@raw_responce['total']
		@options.offset+=@options.limit	
		self.next_page
		@options.current_item= nil
		@options.offset=0
		self.next_item

	end
end

def add_next_page(responce)
	@responce+=responce['items'].map{|i| SpotifyItem.new(i)}
	@options.offset+=@options.limit	
	
end

def next_item
	@responce_total=[]
	@responce_total<<@responce

	while @options.items_id.length>0
		
		responce=SpotifyApiCall.call_s(@type, @options )
		@responce=responce['items'].map{|i| SpotifyItem.new(i)}
		@options=responce[:options]
		@total=responce['total']
		self.next_page
		@options.current_item= nil
		@options.offset=0
		@responce_total<<@responce
		
	end
	
end

def options

	
	@common_options.item_option.endpoint= :songs
	@common_options.item_option.items_id=@albums_id
	unless @albums_id
		self.random_items

		@common_options.item_option.items_id=@responce_total.flatten.map { |album| album.id  }
	end
	@common_options	
	
end


end