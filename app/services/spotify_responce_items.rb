class SpotifyResponceItems<SpotifyResponce

attr_accessor :albums_id

def initialize(options)
	
	@common_options=options
	@options=options.item_option
	@type=@options.endpoint
	
	
	
	
	
	unless @common_options.spotify_ids.empty?

		@common_options.item_option.items_id=@common_options.spotify_ids

	else
		@full_names=Hash.new { |hash, key| hash[key] = []  }
		@options.items_id.each { |e| @full_names[e.attribute_name]<<e.name  }
		@names=@options.items_id.map { |e| e.name }
		super(@type, @options)
		#binding.pry
		@responce=@raw_responce['items'].map{|i| SpotifyItem.new(i)}

		@total=@raw_responce['total']
		@options.offset+=@options.limit	
		self.next_page
		#
 		
		@responce.each{|i| i.attribute_name=(@names[0])}
		@names<<(@names.delete_at 0)
 
		#binding.pry
		@options.current_item= nil
		@options.offset=0
		self.next_item

	end

	
end

def add_next_page(responce)
	@responce+=responce['items'].map{|i| SpotifyItem.new(i)}
	@options.offset+=@options.limit	
	
end

def next_item
	@responce_total=[]
	@responce_total<<@responce

	while @options.items_id.length>0
		
		responce=SpotifyApiCall.call_s(@type, @options )
		@responce=responce['items'].map{|i| SpotifyItem.new(i)}
		@options=responce[:options]
		@total=responce['total']
		self.next_page
		#binding.pry
 
		@responce.each{|i| i.attribute_name=(@names[0])}
		@names<<(@names.delete_at 0)

		#binding.pry
		@options.current_item= nil
		@options.offset=0
		@responce_total<<@responce
		
	end
	#binding.pry
end

def options

	#binding.pry
	@common_options.item_option.endpoint= :songs
	
	unless @common_options.item_option.items_id[0]
		self.random_items

		@common_options.item_option.items_id=@responce_total.flatten
	end
	@common_options	
	
end

def responce_total
	#hash=Hash.new
	@full_names.each do |k,v| 

		hash=Hash.new 
		v.each do |i| hash[i]=@responce_total[0]

			@responce_total<<(@responce_total.delete_at 0)


		end

			@full_names[k]=hash

	end
	
	
	#@responce_total.each_with_index{|i,k| hash[@names[k]]=i }
	@full_names
	#binding.pry
	
end


end