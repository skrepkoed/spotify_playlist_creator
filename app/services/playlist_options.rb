

class PlaylistOptions

attr_accessor :artist_option, :album_option, :song_option

def self.configure(user, params)
	token=user.token.access_token
	
	artist_option=configure_artist(token, params[:number_artists])
	album_option=configure_album(token, params[:number_albums])
	song_option=configure_song(token, params[:number_songs])

	new(artist_option,album_option,song_option)
	
end

def self.configure_artist(token, params)
	artist_options={cursor:nil,token:token,number:params, endpoint: :artists} 
	 
	OpenStruct.new(artist_options)
	
end

def self.configure_album(token, params)
	album_options={offset:0,token:token,number:params, endpoint: :albums, items_id:nil,current_item:nil, limit: 50}

	OpenStruct.new(album_options)
end

def self.configure_song(token,params)

	song_options={offset:0,token:token,number:params, endpoint: :songs, items_id:nil,current_item:nil, limit: 50}

	OpenStruct.new(song_options)
	
end

def initialize(artist_option,album_option, song_option)
	@artist_option, @album_option, @song_option = artist_option,album_option,song_option
end

end