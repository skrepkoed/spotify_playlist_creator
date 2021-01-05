class Playlist < ApplicationRecord
attr_accessor :artist_option, :item_option,  :playlist_option
	belongs_to :user

def initialize(params=nil)
	
	super(params)
	
	unless params==nil
		user=User.find params[:user_id]
		user=user 
		token=user.token.access_token
		spotify_user_id=user.token.spotify_user_id
		configure_artist(token, {artists:number_artists})
		configure_item(token, {albums:number_albums,songs:number_songs})
		configure_playlist(token,playlist_name,spotify_user_id) ###

	end

end


def configure_artist(token, params)
	artist_options={cursor:nil,token:token,number:params, endpoint: :artists, verb: :get} 
	 
	@artist_option=OpenStruct.new(artist_options)
	
end

def configure_item(token, params)
	item_options={offset:0,token:token,number:params, endpoint: nil, items_id:nil,current_item:nil, limit: 50,verb: :get}

	@item_option=OpenStruct.new(item_options)
end

def configure_playlist(token,params,spotify_user_id)

	playlist_options={token:token,name:params,spotify_user_id:spotify_user_id, verb: :post, playlist_id: nil, songs: nil}

	@playlist_option=OpenStruct.new(playlist_options)
	
end


end
