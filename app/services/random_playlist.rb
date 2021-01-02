class RandomPlaylist

attr_reader :artists, :albums 

def self.generate(user)
	
	playlist_options=Hash.new 

	playlist_options[:number_artists]=2
	playlist_options[:number_albums]=1

	options=PlaylistOptions.configure(user,playlist_options)
	
	@artists=SpotifyResponceArtists.new(SpotifyApiCall.call_s( :artists, options.artist_option) ).responce

	options.album_option.artists_id=@artists
	@albums=SpotifyResponceAlbums.new(SpotifyApiCall.call_s(:albums,options.album_option)).responce_total
	
end

end