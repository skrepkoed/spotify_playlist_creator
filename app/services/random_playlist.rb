class RandomPlaylist


def self.generate(user)
	playlist_options=Hash.new 
	playlist_options[:access_token]=user.token.access_token
	playlist_options[:cursor]=nil 
	playlist_options[:artists_id]=nil
	playlist_options[:offset]=nil
	playlist_options[:number]=50
	#binding.pry
	responce=SpotifyResponce.new(SpotifyApiCall.call_s( :artists, playlist_options) )
	#responce.random_items.each{|item| SpotifyResponce.new(SpotifyApiCall.call(playlist_options) )} 
	responce.random_items(playlist_options[:number])
	responce.responce

	
end

end