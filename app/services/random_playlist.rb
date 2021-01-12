class RandomPlaylist

attr_reader :artists, :albums , :songs, :user_id

def self.generate(options)

	artists=SpotifyResponceArtists.new(options).options
	
	albums=SpotifyResponceItems.new(artists).options
	
	songs=SpotifyResponceItems.new(albums).options
	
	
	new(songs.item_option.items_id, options.playlist_option)
	
end

def initialize(songs, options)
	@songs, @user_id, @name = songs, options.spotify_user_id, options.name
	
	playlist_id=SpotifyApiCall.call_s(:create_playlist,options)
	options.playlist_id=playlist_id['id']
	
	options.songs={uris: @songs.map { |e| 'spotify:track:'+e  }}.to_json
	playlist=SpotifyApiCall.call_s(:add_items_to_playlist, options)
	
end

	
end

