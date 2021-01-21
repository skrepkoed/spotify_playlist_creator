class SpotifyResponce

attr_accessor :type , :raw_responce, :total, :options, :responce_total, :responce 

def initialize(endpoint, options )

	@raw_responce=SpotifyApiCall.call_s(endpoint, options)
	
	
end

def next_page

	while @total>@responce.length

		self.add_next_page( SpotifyApiCall.call_s(@type, @options ))	
		
	end
	
end



def random_items
	
	if responce&&responce_total
	@responce_total.map! { |e| e.flatten.shuffle.first(@options.number[@type])  } 
	
	else
	@responce=@responce.shuffle.first(@options.number[@type])
	
	end 
	#binding.pry	
end



end