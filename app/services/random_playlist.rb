class RandomPlaylist

attr_reader :artists, :albums , :songs, :user_id

def self.generate(user)
	
	playlist_options=Hash.new 

	playlist_options[:number_artists]=1
	playlist_options[:number_albums]=1
	playlist_options[:number_songs]=1
	playlist_options[:playlist_name]='First'
	options=PlaylistOptions.configure(user,playlist_options)
	
	artists=SpotifyResponceArtists.new(SpotifyApiCall.call_s(:artists, options.artist_option) ).responce

	options.album_option.items_id=artists
	
	albums=SpotifyResponceItems.new(SpotifyApiCall.call_s(:albums,options.album_option)).responce_total
	
	albums=albums.flatten
	options.song_option.items_id=albums 
	
	songs=SpotifyResponceItems.new(SpotifyApiCall.call_s(:songs,options.song_option)).responce_total
	songs=songs.flatten

	#@playlist=SpotifyApiCall.call_s(:create_playlist, options.playlist_options)
	new(songs, options.playlist_option)
end

def initialize(songs, options)
	@songs, @user_id, @name = songs, options.spotify_user_id, options.name
	@songs.map! { |song| 'spotify:track:'+song }
	playlist_id=SpotifyApiCall.call_s(:create_playlist,options)
	options.playlist_id=playlist_id['id']
	options.songs={uris: @songs}.to_json
	playlist=SpotifyApiCall.call_s(:add_items_to_playlist, options)
	binding.pry
end

	
end

