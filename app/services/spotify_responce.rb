class SpotifyResponce

attr_accessor :type , :responce,  :total, :options

def initialize(responce)
	
	
	@endpoint=responce[:endpoint]
	@options=responce[:options]
	#binding.pry
	
end

def next_page

	while @total>@responce.length

		self.add_next_page( SpotifyApiCall.call_s(@endpoint, @options ))

		

		
		
	end

	self.random_items
	
end

def random_items
	#number=('number_'+@type).to_sym

	@responce=@responce.shuffle.first(@options.number)
	
end



end