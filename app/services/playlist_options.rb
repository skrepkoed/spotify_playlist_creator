

class PlaylistOptions

attr_accessor :artist_option, :album_option

def self.configure(user, params)
	token=user.token.access_token
	#binding.pry
	artist_option=configure_artist(token, params[:number_artists])
	album_option=configure_album(token, params[:number_albums])

	new(artist_option,album_option)
	
end

def self.configure_artist(token, params)
	artist_options={cursor:nil,token:token,number:params, endpoint: :artists} 
	 
	OpenStruct.new(artist_options)
	
end

def self.configure_album(token, params)
	album_options={offset:0,token:token,number:params, endpoint: :albums, artists_id:nil}

	OpenStruct.new(album_options)
end

def initialize(artist_option,album_option)
	@artist_option, @album_option = artist_option,album_option
end

end