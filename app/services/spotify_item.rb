

class SpotifyItem<OpenStruct

	#attr_accessor :artist_name, :album_name, :song_name
	#attr_accessor :attribute_name
	def initialize(element)

		element=element.select{|k| k=='id'||k=='name'||k=='type'||k=='uri'||k=='genres'||k=='attribute_name' }
		super(element)
			unless attribute_name
			self[:attribute_name]=nil
			self
		end
	end

	def name_with_genres

		[name,genres]
		
	end

	def name_with_id
		if attribute_name
		{attribute_name: attribute_name, name:name,id:id} .to_json
		else
			{name:name,id:id}.to_json
		end
		
	end


end

class Artist<OpenStruct

end

class Album<OpenStruct

end

class Song<OpenStruct

end