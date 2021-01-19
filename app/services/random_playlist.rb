class RandomPlaylist

attr_reader :artists, :albums , :songs, :user_id

def self.generate(options)
	if options.number_artists
	artists=SpotifyResponceArtists.new(options).options
	end
	if options.number_albums
		albums=SpotifyResponceItems.new(artists).options
		else
			options.item_option.items_id=options.spotify_ids
			options.item_option.endpoint= :songs
			options.spotify_ids=[]
			albums=options
	end
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

