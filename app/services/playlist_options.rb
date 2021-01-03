

class PlaylistOptions

attr_accessor :artist_option, :album_option, :song_option, :playlist_option

def self.configure(user, params)
	token=user.token.access_token
	spotify_user_id=user.token.spotify_user_id
	artist_option=configure_artist(token, params[:number_artists])
	album_option=configure_album(token, params[:number_albums])
	song_option=configure_song(token, params[:number_songs])
	playlist_option=configure_playlist(token,params[:playlist_name],spotify_user_id)

	new(artist_option,album_option,song_option,playlist_option)
	
end

def self.configure_artist(token, params)
	artist_options={cursor:nil,token:token,number:params, endpoint: :artists, verb: :get} 
	 
	OpenStruct.new(artist_options)
	
end

def self.configure_album(token, params)
	album_options={offset:0,token:token,number:params, endpoint: :albums, items_id:nil,current_item:nil, limit: 50,verb: :get}

	OpenStruct.new(album_options)
end

def self.configure_song(token,params)

	song_options={offset:0,token:token,number:params, endpoint: :songs, items_id:nil,current_item:nil, limit: 50,verb: :get}

	OpenStruct.new(song_options)
	
end

def self.configure_playlist(token,params,spotify_user_id)

	playlist_options={token:token,name:params,spotify_user_id:spotify_user_id, verb: :post, playlist_id: nil, songs: nil}

	OpenStruct.new(playlist_options)
	
end

def initialize(artist_option,album_option, song_option,playlist_option)
	@artist_option, @album_option, @song_option, @playlist_option = artist_option,album_option,song_option,playlist_option
end

end