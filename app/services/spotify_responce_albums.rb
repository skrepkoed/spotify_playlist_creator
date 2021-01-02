class SpotifyResponceAlbums<SpotifyResponce

attr_accessor :responce_total

def initialize(responce)
	#binding.pry
	#@type=responce.keys[0] ###
	super(responce)	
	@responce=responce['items'].map{|i| i['name']}
	@total=responce['total']
	#binding.pry
	@options.offset=responce['offset']	
	#self.next_page

	self.next_artist_albums
end

def add_next_page(responce)
=begin
	@type=responce.keys[0]
	@responce+=responce[@type]['items'].map! { |e| e['id']  }
	@options[:cursor] =responce [@type]['cursors']['after']
	#@options[:offset]+=50

=end
	
end

def next_artist_albums
	@responce_total=[]
	self.random_items
	@responce_total<<@responce
	while @options.artists_id.length>0

		responce=SpotifyApiCall.call_s(@endpoint, @options )
		@responce=responce['items'].map{|i| i['name']}
		@options=responce[:options]
		#binding.pry
		self.random_items

		@responce_total<<@responce
		
	end
	
end


end