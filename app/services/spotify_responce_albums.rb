class SpotifyResponceAlbums<SpotifyResponce

attr_accessor :responce_total

def initialize(responce)
	
	super(responce)	
	@responce=responce['items'].map{|i| i['name']}
	@total=responce['total']
	
	@options.offset+=@options.limit	
	
	self.next_page
	@options.current_artist= nil
	@options.offset=0
	self.next_artist_albums
end

def add_next_page(responce)

	
	@responce+=responce['items'].map{|i| i['name']}
	@options.offset+=@options.limit	
	
	
	
end

def next_artist_albums
	@responce_total=[]
	

	@responce_total<<@responce
	while @options.artists_id.length>0

		responce=SpotifyApiCall.call_s(@endpoint, @options )
		@responce=responce['items'].map{|i| i['name']}
		@options=responce[:options]
		@total=responce['total']
		
		self.next_page
		@options.current_artist= nil
		@options.offset=0
		

		@responce_total<<@responce
		
	end
	
end


end