class RandomPlaylist

attr_reader :artists, :albums , :songs, :user_id

def self.generate(options)

	artists=SpotifyResponceArtists.new(options).options
	#binding.pry
	albums=SpotifyResponceItems.new(artists).options
	#binding.pry
	songs=SpotifyResponceItems.new(albums).options
	
	
	new(songs.item_option.items_id, options.playlist_option)
	
end

def initialize(songs, options)
	@songs, @user_id, @name = songs, options.spotify_user_id, options.name
	
	playlist_id=SpotifyApiCall.call_s(:create_playlist,options)
	options.playlist_id=playlist_id['id']
	@songs.each_slice(100) do |songs|
		options.songs={uris: songs.map { |e| 'spotify:track:'+e.id  }}.to_json
		playlist=SpotifyApiCall.call_s(:add_items_to_playlist, options)
	end
	
end

	
end

