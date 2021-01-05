class SpotifyResponceArtists<SpotifyResponce
attr_accessor :responce 

def initialize(options)
	@common_options=options
	@options=options.artist_option
	@type=@options.endpoint
	super(@type, @options)
	@total=@raw_responce['artists'] ['total']
	@responce=@raw_responce['artists']['items'].map! { |e| SpotifyItem.new(e)  }
	@options.cursor=@raw_responce ['artists']['cursors']['after']
	self.next_page
end

def add_next_page(responce)
	@responce+=responce['artists']['items'].map! { |e| SpotifyItem.new(e)  }
	@options.cursor =responce ['artists']['cursors']['after']
end


def options
	self.random_items
	artists_id=@responce.map { |artist| artist.id  }
	@common_options.item_option.endpoint= :albums
	@common_options.item_option.items_id=artists_id
	@common_options	
end


end