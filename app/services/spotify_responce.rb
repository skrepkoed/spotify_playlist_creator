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
	@responce_total=@responce_total.flatten.shuffle.first(@options.number[@type])
	
	else
	@responce=@responce.shuffle.first(@options.number[@type])
	
	end 	
end

def filtred_responce(&block)

	if responce 

	 	responce.map(&block)

	else

	 	responce_total.flatten.map(&block)
	end

	
end



end