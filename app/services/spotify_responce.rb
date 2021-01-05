class SpotifyResponce

attr_accessor :type , :raw_responce, :total, :options

def initialize(endpoint, options )

	@raw_responce=SpotifyApiCall.call_s(endpoint, options)
	
	
end

def next_page

	while @total>@responce.length

		self.add_next_page( SpotifyApiCall.call_s(@type, @options ))	
		
	end
	
end



def random_items
	

	@responce=@responce.shuffle.first(@options.number[@type])
	
end



end