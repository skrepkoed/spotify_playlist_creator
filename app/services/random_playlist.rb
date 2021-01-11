class RandomPlaylist

attr_reader :artists, :albums , :songs, :user_id

def self.generate(options)

	artists=SpotifyResponceArtists.new(options).options
	
	albums=SpotifyResponceItems.new(artists).options
	
	songs=SpotifyResponceItems.new(albums).options
	binding.pry
	songs.spotify_ids.delete_if{|i| i==''}
	#songs=songs.flattens
	new(songs.spotify_ids, options.playlist_option)
	
end

def initialize(songs, options)
	@songs, @user_id, @name = songs, options.spotify_user_id, options.name
	#songs_uris=@songs.map { |song| song.uri }
	#binding.pry
	playlist_id=SpotifyApiCall.call_s(:create_playlist,options)
	options.playlist_id=playlist_id['id']
	#binding.pry
	options.songs={uris: @songs.map { |e| 'spotify:track:'+e  }}.to_json
	playlist=SpotifyApiCall.call_s(:add_items_to_playlist, options)
	#binding.pry
end

	
end

