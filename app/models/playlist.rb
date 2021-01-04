class Playlist < ApplicationRecord
attr_accessor :artist_option, :album_option, :song_option, :playlist_option
	belongs_to :user

def initialize(params=nil)
	#@artist_option, @album_option, @song_option, @playlist_option = artist_option,album_option,song_option,playlist_option
	
	super(params)
	
	unless params==nil
		#binding.pry
		user=User.find params[:user_id]
		user=user 
		token=user.token.access_token
		spotify_user_id=user.token.spotify_user_id
		configure_artist(token, number_artists)
		configure_album(token, number_albums)
		configure_song(token, number_songs)
		configure_playlist(token,playlist_name,spotify_user_id) ###

	end

end


def configure_artist(token, params)
	artist_options={cursor:nil,token:token,number:params, endpoint: :artists, verb: :get} 
	 
	@artist_option=OpenStruct.new(artist_options)
	
end

def configure_album(token, params)
	album_options={offset:0,token:token,number:params, endpoint: :albums, items_id:nil,current_item:nil, limit: 50,verb: :get}

	@album_option=OpenStruct.new(album_options)
end

def configure_song(token,params)

	song_options={offset:0,token:token,number:params, endpoint: :songs, items_id:nil,current_item:nil, limit: 50,verb: :get}

	@song_option=OpenStruct.new(song_options)
	
end

def configure_playlist(token,params,spotify_user_id)

	playlist_options={token:token,name:params,spotify_user_id:spotify_user_id, verb: :post, playlist_id: nil, songs: nil}

	@playlist_option=OpenStruct.new(playlist_options)
	
end
end
