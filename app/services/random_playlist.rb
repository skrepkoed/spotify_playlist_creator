class RandomPlaylist

attr_reader :artists, :albums 

def self.generate(user)
	
	playlist_options=Hash.new 

	playlist_options[:number_artists]=3
	playlist_options[:number_albums]=2
	playlist_options[:number_songs]=1

	options=PlaylistOptions.configure(user,playlist_options)
	
	@artists=SpotifyResponceArtists.new(SpotifyApiCall.call_s( :artists, options.artist_option) ).responce

	options.album_option.items_id=@artists
	
	@albums=SpotifyResponceItems.new(SpotifyApiCall.call_s(:albums,options.album_option)).responce_total
	
	@albums=@albums.flatten
	options.song_option.items_id=@albums 
	
	@songs=SpotifyResponceItems.new(SpotifyApiCall.call_s(:songs,options.song_option)).responce_total
	
end
=begin
def initialize(songs, user_id,name)
	@songs, @user_id, @name = songs, user_id, name
end
=end
end