class SpotifyResponce

attr_accessor :type , :responce, :cursor, :total

def initialize(responce)
	@user=responce.delete(:user)
	@type=responce.keys[0]
	@responce=responce[@type]['items']
	#@cursor=responce [@type]['cursors']['after']
	@total=responce[@type]['total']
	@options=responce[:options]
	@options[:cursor]=responce [@type]['cursors']['after']
	@endpoint=responce[:endpoint]

	self.next_page

	
end

def next_page

	if @total>@responce.length

		self.add_next_page( SpotifyApiCall.call_s(@endpoint, @options ))

		#binding.pry

		self.next_page
		
	end

	
	
end

def random_items(number)

	@responce=@responce.shuffle.first(number)
	
end

def add_next_page(responce)
	@type=responce.keys[0]
	@responce+=responce[@type]['items']
	@options[:cursor] =responce [@type]['cursors']['after']
	
end

end