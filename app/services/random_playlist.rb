class RandomPlaylist

attr_reader :artists, :albums 

def self.generate(user)
	
	playlist_options=Hash.new 
=begin
	playlist_options[:access_token]=user.token.access_token
	playlist_options[:cursor]=nil 
	
	playlist_options[:offset]=0
=end
	playlist_options[:number_artists]=3
	playlist_options[:number_albums]=1

	options=PlaylistOptions.configure(user,playlist_options)
	#binding.pry
	@artists=SpotifyResponceArtists.new(SpotifyApiCall.call_s( :artists, options.artist_option) ).responce

	options.album_option.artists_id=@artists
	@albums=SpotifyResponceAlbums.new(SpotifyApiCall.call_s(:albums,options.album_option)).responce_total
	#binding.pry
=begin
	@albums=[]
	@artists.each do |artist|

		playlist_options[:artist_id]=artist

		@albums<<SpotifyResponce.new(SpotifyApiCall.call_s( :albums, playlist_options) )


		
	end	

binding.pry
=end	
end

end