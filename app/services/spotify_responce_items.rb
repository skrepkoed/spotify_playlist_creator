class SpotifyResponceItems<SpotifyResponce

attr_accessor :responce_total

def initialize(responce)
	
	super(responce)	
	
	@responce=responce['items'].map{|i| i['id']}
	@total=responce['total']
	
	@options.offset+=@options.limit	
	
	self.next_page
	@options.current_item= nil
	@options.offset=0

	self.next_item
end

def add_next_page(responce)
	@responce+=responce['items'].map{|i| i['id']}
	@options.offset+=@options.limit	
	
end

def next_item
	
	@responce_total=[]
	

	@responce_total<<@responce

	while @options.items_id.length>0

		responce=SpotifyApiCall.call_s(@endpoint, @options )
		@responce=responce['items'].map{|i| i['id']}
		@options=responce[:options]
		@total=responce['total']
		
		self.next_page
		@options.current_item= nil
		@options.offset=0
		

		@responce_total<<@responce
		
	end
	
end


end