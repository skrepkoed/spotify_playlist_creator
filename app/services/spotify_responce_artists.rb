class SpotifyResponceArtists<SpotifyResponce


def initialize(responce)
	@type=responce.keys[0]
	@total=responce[type]['total']
	super(responce)	
	@responce=responce[@type]['items'].map! { |e| SpotifyItems.new(e)  }
	#binding.pry
	@options.cursor=responce [@type]['cursors']['after']
	
	self.next_page
end

def add_next_page(responce)
	
	@type=responce.keys[0]
	@responce+=responce[@type]['items'].map! { |e| SpotifyItems.new(e)  }
	@options[:cursor] =responce [@type]['cursors']['after']
	
	
end


end