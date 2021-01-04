class RandomPlaylist

attr_reader :artists, :albums , :songs, :user_id

def self.generate(options)

	artists=SpotifyResponceArtists.new(SpotifyApiCall.call_s(:artists, options.artist_option) ).responce

	options.album_option.items_id=artists.map { |artist| artist.id  }
	
	albums=SpotifyResponceItems.new(SpotifyApiCall.call_s(:albums,options.album_option)).responce_total
	
	albums=albums.flatten
	options.song_option.items_id=albums.map { |album| album.id  }  
	
	songs=SpotifyResponceItems.new(SpotifyApiCall.call_s(:songs,options.song_option)).responce_total
	songs=songs.flatten
	[artists,albums,songs].flatten
	
	new(songs, options.playlist_option)
	[artists,albums,songs].flatten
end

def initialize(songs, options)
	@songs, @user_id, @name = songs, options.spotify_user_id, options.name
	songs_uris=@songs.map { |song| song.uri }
	playlist_id=SpotifyApiCall.call_s(:create_playlist,options)
	options.playlist_id=playlist_id['id']
	options.songs={uris: songs_uris}.to_json
	playlist=SpotifyApiCall.call_s(:add_items_to_playlist, options)
	
end

	
end

