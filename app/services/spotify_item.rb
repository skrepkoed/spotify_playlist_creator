

class SpotifyItem<OpenStruct

	def initialize(element)

		element=element.select{|k| k=='id'||k=='name'||k=='type'||k=='uri'||k=='genres' }
		super(element)
	end

	def name_with_genres

		[name,genres]
		
	end

	def name_with_id

		{name:name,id:id}.to_json
		
	end


end

class Artist<OpenStruct

end

class Album<OpenStruct

end

class Song<OpenStruct

end